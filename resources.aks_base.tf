# AKS Cluster
data "azurerm_kubernetes_service_versions" "current" {
  location       = var.aks_location
  version_prefix = var.aks_version_prefix
}

resource "azurerm_kubernetes_cluster" "priv_aks" {
    name                          = var.aks_name
    location                      = var.aks_location
    kubernetes_version            = var.aks_version
    resource_group_name           = module.aks_network.resource_group_name
    dns_prefix                    = var.aks_name
    private_cluster_enabled       = var.aks_prive_cluster_enabled

    default_node_pool {
      name                = var.aks_default_node_pool_name 
      node_count          = var.aks_default_node_count
      enable_auto_scaling = var.aks_default_node_enable_auto_scaling
      vm_size             = var.aks_default_node_vm_size
      max_pods            = var.aks_default_node_max_pods
      max_count           = var.aks_default_node_max_count
      min_count           = var.default_node_pool_min_count
      os_disk_type        = var.default_node_pool_os_type
      tags                = var.tags
    }
/*
    linux_profile {
    admin_username = var.admin_username
    ssh_key {
       key_data = var.ssh_public_key
     }
    }
*/
    identity {
      type = "SystemAssigned"
    }

  network_profile {
    #dns_service_ip     = var.network_dns_service_ip
    network_plugin     = var.network_plugin
    #outbound_type      = var.outbound_type
    #service_cidr       = var.network_service_cidr
  }

  oms_agent {
    msi_auth_for_monitoring_enabled = true
    log_analytics_workspace_id      = data.azurerm_log_analytics_workspace.hub-logws.id
                                      #coalesce(var.oms_agent.log_analytics_workspace_id, var.log_analytics_workspace_id)
  }
/*
   azure_active_directory_role_based_access_control {
    managed                    = true
    tenant_id                  = var.tenant_id
    admin_group_object_ids     = var.admin_group_object_ids
    azure_rbac_enabled         = var.azure_rbac_enabled
  }
/*
  workload_autoscaler_profile {
    keda_enabled                    = var.keda_enabled
    vertical_pod_autoscaler_enabled = var.vertical_pod_autoscaler_enabled
  }
*/
  lifecycle {
    ignore_changes = [
      kubernetes_version,
      tags
    ]
  }

    tags = {
        Environment = "dev"
        Project = "priv_aks"
    }

  depends_on = [ module.aks_network.resource_group_name ]
}
