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
/*
output "aks_subnet_id" {
  description = "aks subnet ID"
  value = data.azurerm_subnet.aks_subnet.id
  
}
*/
/*
data "azurerm_subnet" "aks_subnet" {
    name                 = "${data.azurerm_subenet.aks_subnet.name}" #"${data.azurerm_virtual_network.vnet.subnets[count.index]}"
    virtual_network_name = "${data.azurerm_virtual_network.aks_vnet.name}"
    resource_group_name  = "${data.azurerm_resource_group.aks_rg.name}"
    count = "${count(data.azurerm_virtual_network.aks_vnet.subnets)}"
}

 output "subnet_ids" {
     value = "${data.azurerm_subnet.aks_subnet.*.id}"
 }
*/