resource "azurerm_container_registry" "aks_acr" {
  name                          = "tfnoopsacr"
  resource_group_name           = local.resource_group_name
  location                      = local.location
  sku                           = "Premium"
  public_network_access_enabled = false
  admin_enabled                 = true
}


output "acr_id" {
  value = azurerm_container_registry.aks_acr.id
}

