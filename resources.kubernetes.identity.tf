# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.
/*
resource "azurerm_user_assigned_identity" "aks" {
  count = (var.identity_type == "UserAssigned" && var.user_assigned_identity == null ? 1 : 0)

  resource_group_name = local.resource_group_name
  location            = local.location
  name                = local.user_assigned_identity_name

  tags                = var.add_tags

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}
*/
resource "azurerm_role_assignment" "subnet_network_contributor" {
  for_each = (var.virtual_network == null ? {} : (var.configure_network_role ? var.virtual_network.subnets : {}))

  scope                = each.value.id
  role_definition_name = "Network Contributor"
  principal_id         = local.aks_identity_id
}

/*
resource "azurerm_role_assignment" "route_table_network_contributor" {
  count = (var.virtual_network == null ? 0 : 1)

  scope                = var.virtual_network.route_table_id
  role_definition_name = "Network Contributor"
  principal_id = (var.user_assigned_identity == null ? azurerm_user_assigned_identity.aks.0.principal_id :
  var.user_assigned_identity.principal_id)
}
*/
resource "azurerm_user_assigned_identity" "aks_identity" {
name                    = "aks-identity"
resource_group_name     = local.resource_group_name
location                = local.location
}

resource "azurerm_role_assignment" "aks_identity_assignment" {
  principal_id          = azurerm_user_assigned_identity.aks_identity.principal_id
  role_definition_name  = "Contributor"
  scope                 = azurerm_kubernetes_cluster.aks_cluster.id 
}

resource "azurerm_role_assignment" "aks_identity_contributor" {
  principal_id          = azurerm_user_assigned_identity.aks_identity.principal_id
  role_definition_name  = "Contributor"  # You can use a more specific role if needed
  scope                 = "/subscriptions/df79eff1-4ca3-4d21-9c6b-64dd15c253e8/resourceGroups/tf-noops-gov-rg-aks-udr-kn/providers/Microsoft.Network/routeTables/rt-aks-udr-kn" #azurerm_route_table.rt.id
}
