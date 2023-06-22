# Azurerm provider configuration
provider "azurerm" {
  environment = "USGovernment"
  skip_provider_registration = "true"
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}
data "azurerm_virtual_network" "hub-vnet" {
  name                = "tf-anoa-usgaz-hub-core-dev-vnet"
  resource_group_name = "tf-anoa-usgaz-hub-core-dev-rg"
}

data "azurerm_storage_account" "hub-st" {
  name                = "tfanoausgaz3202fb10aedev"
  resource_group_name = "tf-anoa-usgaz-hub-core-dev-rg"
}

data "azurerm_log_analytics_workspace" "hub-logws" {
  name                = "tf-anoa-usgaz-ops-mgt-logging-dev-log"
  resource_group_name = "tf-anoa-usgaz-ops-mgt-logging-dev-rg"
}

module "aks_network" {
  source                = "azurenoops/overlays-workload-spoke/azurerm"
  version               = "2.0.3"
  create_resource_group = true
  location              = var.aks_location 
  deploy_environment    = var.aks_deploy_environment
  org_name              = var.aks_org_name
  environment           = var.aks_environment
  workload_name         = var.aks_workload_name

# Collect Hub Virtual Network Parameters
# Hub network details to create peering and other setup
hub_virtual_network_id          = data.azurerm_virtual_network.hub-vnet.id
hub_firewall_private_ip_address = "10.0.100.4"  
hub_storage_account_id          = data.azurerm_storage_account.hub-st.id

# (Required) To enable Azure Monitoring and flow logs
# pick the values for log analytics workspace which created by Hub module
# Possible values range between 30 and 730
log_analytics_workspace_id           = data.azurerm_log_analytics_workspace.hub-logws.id
log_analytics_customer_id            = data.azurerm_log_analytics_workspace.hub-logws.workspace_id
log_analytics_logs_retention_in_days = 30

# Provide valid VNet Address space for spoke virtual network.    
virtual_network_address_space = ["10.0.100.0/24"] # (Required)  Hub Virtual Network Parameters

# (Required) Specify if you are deploying the spoke VNet using the same hub Azure subscription
is_spoke_deployed_to_same_hub_subscription = true

# (Required) Multiple Subnets, Service delegation, Service Endpoints, Network security groups
# These are default subnets with required configuration, check README.md for more details
# Route_table and NSG association to be added automatically for all subnets listed here.
# subnet name will be set as per Azure naming convention by defaut. expected value here is: <App or project name>
  spoke_subnets = {
    default = {
      name                                       = "AKS_subnet"
      address_prefixes                           = ["10.0.100.64/26"]
      service_endpoints                          = ["Microsoft.Storage"]
      private_endpoint_network_policies_enabled  = false
      private_endpoint_service_endpoints_enabled = true
    }
  }

# By default, forced tunneling is enabled for the spoke.
# If you do not want to enable forced tunneling on the spoke route table, 
# set `enable_forced_tunneling = false`.
enable_forced_tunneling_on_route_table = true

# Private DNS Zone Settings
# By default, Azure NoOps will create Private DNS Zones for Logging in Hub VNet.
# If you do want to create addtional Private DNS Zones, 
# add in the list of private_dns_zones to be created.
# else, remove the private_dns_zones argument.
#private_dns_zones_to_link_to_hub = ["privatelink.file.core.windows.net"]  

# By default, this will apply resource locks to all resources created by this module.
# To disable resource locks, set the argument to `enable_resource_locks = false`.
enable_resource_locks = false

# Tags
add_tags = {
Example = "Workload Identity Core Spoke"
} # Tags to be applied to all resources
}

# AKS Cluster
data "azurerm_kubernetes_service_versions" "current" {
  location       = var.aks_location
  version_prefix = var.aks_version_prefix
}

resource "azurerm_kubernetes_cluster" "priv_aks" {
    name = var.aks_name
    location = var.aks_location
    kubernetes_version = var.aks_version
    resource_group_name = var.aks_resourse_group_name
    dns_prefix = var.aks_name
    private_cluster_enabled = true

    network_profile {
        network_plugin = "azure"
        network_policy = "calico"
    }

    default_node_pool {
      name          = var.aks_default_node_pool_name 
      node_count    = var.aks_default_node_count
      vm_size       = var.aks_default_node_vm_size
    }

    identity {
      type = "SystemAssigned"
    }
    tags = {
        Environment = "dev"
        Project = "priv_aks"
    }
}