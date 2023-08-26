# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

#---------------------------------------------------------
# Azure Region Lookup
#----------------------------------------------------------
# Azurerm provider configuration
provider "azurerm" {
  environment                = "USGovernment"
  skip_provider_registration = "true"
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}

module "mod_azure_region_lookup" {
  source  = "azurenoops/overlays-azregions-lookup/azurerm"
  version = "~> 1.0.1"

  azure_region = "usgovvirginia"
}

module "aks_cluster" {
  source                       = "../.."
  depends_on                   = [azurerm_resource_group.aks_rg]
  create_aks_resource_group    = false
  location                     = var.location
  existing_resource_group_name = azurerm_resource_group.aks_rg.name
  org_name                     = var.org_name
  deploy_environment           = var.deploy_environment
  workload_name                = var.workload_name
  environment                  = var.environment
  dns_prefix                   = "testaksdns"

  azure_policy_enabled       = true
  log_analytics_workspace_id = azurerm_log_analytics_workspace.aks.id

}

