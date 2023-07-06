
resource "azurerm_resource_group" "aks_rg" {
  name     = "rg-aks"
  location = module.mod_azure_region_lookup.location_cli
}

resource "azurerm_virtual_network" "aks_vnet" {
  name                = "vnet-aks"
  location            = module.mod_azure_region_lookup.location_cli
  resource_group_name = azurerm_resource_group.aks_rg.name
  address_space       = ["10.1.0.0/22"]

  route_tables = {
    aks = {
      disable_bgp_route_propagation = true
      use_inline_routes             = false
      routes = {
        internet = {
          address_prefix         = "0.0.0.0/0"
          next_hop_type          = "Internet"
        }
        local-vnet = {
          address_prefix         = "10.1.0.0/22"
          next_hop_type          = "vnetlocal"
        }
      }
    }
  }
}

resource "azurerm_subnet" "aks_subnet" {
  name                 = "iaas-private-aks"
  resource_group_name  = azurerm_resource_group.aks_rg.name
  virtual_network_name = azurerm_virtual_network.aks_vnet.name
  address_prefixes     =  ["10.1.0.0/24"]
}

resource "azurerm_subnet" "aks_subnet" {
  name                 = "iaas-private-public"
  resource_group_name  = azurerm_resource_group.aks_rg.name
  virtual_network_name = azurerm_virtual_network.aks_vnet.name
  address_prefixes     = ["10.1.1.0/24"]
}



