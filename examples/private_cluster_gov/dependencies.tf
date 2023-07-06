
resource "azurerm_resource_group" "aks_rg" {
  name     = "rg-aks"
  location = module.mod_azure_region_lookup.location_cli
}

resource "azurerm_virtual_network" "aks_vnet" {
  name                = "vnet-aks"
  location            = module.mod_azure_region_lookup.location_cli
  resource_group_name = azurerm_resource_group.aks_rg.name
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "aks_subnet" {
  name                 = "snet-aks"
  resource_group_name  = azurerm_resource_group.aks_rg.name
  virtual_network_name = azurerm_virtual_network.aks_vnet.name
  address_prefixes     = ["10.0.2.0/24"]
}


