# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.
# remove file if not needed
data "azurerm_subscription" "current" {}

data "azurerm_virtual_network" "aks_vnet" {
  name                = reverse(split("/", var.vnet_id))[0]
  resource_group_name = split("/", var.vnet_id)[4]
}

data "azurecaf_name" "aks_identity" {
  name                = var.aks_user_assigned_identity_custom_name
}

data "azurecaf_name" "aks" {
  name                = var.custom_aks_name
}

data "azurecaf_name" "appgw_identity" {
  name                = var.appgw_user_assigned_identity_custom_name
}

data "azurecaf_name" "appgw" {
  name                = var.custom_appgw_name
}

data "azurerm_kubernetes_cluster" "aks_cluster" {
  name                = var.aks_name
  resource_group_name = var.existing_resource_group_name
}

output "ssh_public_key" {
  value = data.azurerm_kubernetes_cluster.aks_cluster.linux_profile.0.ssh_key.0.key_data
}



