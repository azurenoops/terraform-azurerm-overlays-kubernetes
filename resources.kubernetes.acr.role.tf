
resource "azurerm_role_assignment" "aks_acr_pull_allowed" {
  for_each = toset(var.acr_pull_access)

  principal_id         = azurerm_user_assigned_identity.aks_user_assigned_identity.principal_id
  scope                = each.value
  role_definition_name = "AcrPull"
}