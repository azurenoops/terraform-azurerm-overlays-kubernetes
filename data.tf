# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

# remove file if not needed
data "azurerm_subscription" "current" {}
#data "azuread_client_config" "current" {}

data "azurerm_client_config" "current" {}

#read the AKS subenet data
data "azurerm_subnet" "aks_subnet" {
  name                 = "snet-aks" #var.aks_subnet_name
  virtual_network_name = "vnet-aks" #var.vnet_name
  resource_group_name  = "tf-anoa-gov-rg-aks" #var.vnet_resource_group_name
}

#read the AKS vnet data
data "azurerm_virtual_network" "aks_vnet" {
    name                = "vnet-aks" #var.vnet_name
    resource_group_name = "tf-anoa-gov-rg-aks" #var.vnet_resource_group_name
  
}