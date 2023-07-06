# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

resource "azurerm_user_assigned_identity" "aks" {
  count = (var.identity_type == "UserAssigned" && var.user_assigned_identity == null ? 1 : 0)

  resource_group_name = var.resource_group_name
  location            = var.location
  name                = local.user_assigned_identity_name

  tags                = var.add_tags

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

resource "azurerm_role_assignment" "subnet_network_contributor" {
  for_each = (var.virtual_network == null ? {} : (var.configure_network_role ? var.virtual_network.subnets : {}))

  scope                = each.value.id
  role_definition_name = "Network Contributor"
  principal_id         = local.aks_identity_id
}

resource "azurerm_role_assignment" "route_table_network_contributor" {
  count = (var.virtual_network == null ? 0 : 1)

  scope                = var.virtual_network.route_table_id
  role_definition_name = "Network Contributor"
  principal_id = (var.user_assigned_identity == null ? azurerm_user_assigned_identity.aks.0.principal_id :
  var.user_assigned_identity.principal_id)
}