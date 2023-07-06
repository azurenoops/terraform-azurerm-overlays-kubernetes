# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

resource "azurerm_role_assignment" "network_contributor" {
  scope                = local.resource_group_name
  role_definition_name = "Network Contributor"
  principal_id         = module.aks_cluster.aks_identity_principal_id
  skip_service_principal_aad_check = true
}

resource "azurerm_role_assignment" "aks_acr_pull_allowed" {
  for_each = toset(var.acr_pull_access)

  principal_id         = azurerm_user_assigned_identity.aks_user_assigned_identity.principal_id
  scope                = each.value
  role_definition_name = "AcrPull"
}
