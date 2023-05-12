
resource "azurerm_user_assigned_identity" "aks_identity" {
  resource_group_name = local.resource_group_name
  location            = local.location
  tags                = var.add_tags

  name = "${var.name}Identity"

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}