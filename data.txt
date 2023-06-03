# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

# remove file if not needed
data "azurerm_subscription" "current" {}

data "azurerm_virtual_network" "aks_vnet" {
  name                = reverse(split("/", var.vnet_id))[0]
  resource_group_name = split("/", var.vnet_id)[4]
}