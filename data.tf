# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.
# remove file if not needed
data "azurerm_subscription" "current" {}
data "azurerm_client_config" "current" {}

data "azurerm_subnet" "aks_subnet" {
  name                 = "snet-aks"
  virtual_network_name = "vnet-aks"
  resource_group_name  = "tf-anoa-gov-rg-aks"
  
}

data "azurerm_virtual_network" "aks_vnet" {
  name                = "vnet-aks"
  resource_group_name = "tf-anoa-gov-rg-aks"
}
