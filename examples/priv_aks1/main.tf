#deploys an aks using the AKS module
#providers info
# Azurerm provider configuration
provider "azurerm" {
  environment = "USGovernment"
  skip_provider_registration                   = "true"
  features {
    resource_group {
      prevent_deletion_if_contains_resources   = false
    }
  }
}

module "aks_cluster" {
    source = "../.."
    create_resource_group           = false
    location                        = var.location
    existing_resource_group_name    = var.existing_resource_group_name
    org_name                        = var.org_name
    deploy_environment              = var.deploy_environment
    workload_name                   = var.workload_name   
}