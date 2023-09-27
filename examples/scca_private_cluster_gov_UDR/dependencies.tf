resource "azurerm_resource_group" "aks_rg" {
  name     = "tf-noops-gov-rg-aks-udr"
  location = module.mod_azure_region_lookup.location_cli
}

resource "azurerm_virtual_network" "aks_vnet" {
  name                = "vnet-aks-udr"
  location            = module.mod_azure_region_lookup.location_cli
  resource_group_name = azurerm_resource_group.aks_rg.name
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "aks_subnet_udr" {
  name                 = "snet-aks-udr"
  resource_group_name  = azurerm_resource_group.aks_rg.name
  virtual_network_name = azurerm_virtual_network.aks_vnet.name
  address_prefixes     = ["10.0.3.0/24"]
  private_endpoint_network_policies_enabled = false 
}

resource "azurerm_route_table" "rt" {
  name                = "rt-aks-udr"
  location            = module.mod_azure_region_lookup.location_cli
  resource_group_name = azurerm_resource_group.aks_rg.name
  
  route {
    name                   = "kubenetfw_fw_r"
    address_prefix         = "0.0.0.0/0"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = var.firewall_private_ip
  }
}

resource "azurerm_subnet_route_table_association" "snet_rt" {
  subnet_id      = azurerm_subnet.aks_subnet_udr.id
  route_table_id = azurerm_route_table.rt.id
}
### hub-spoke peering
resource "azurerm_virtual_network_peering" "aks_spoke_to_hub" {
  name                                = "aks_spoke_to_hub"
  resource_group_name                 = azurerm_resource_group.aks_rg.name
  allow_forwarded_traffic             = true
  allow_virtual_network_access        = true
  #allow_remote_virtual_network_access = true
  virtual_network_name                = "vnet-aks-udr"
  remote_virtual_network_id           = "/subscriptions/df79eff1-4ca3-4d21-9c6b-64dd15c253e8/resourceGroups/tf-anoa-usgaz-hub-core-dev-rg/providers/Microsoft.Network/virtualNetworks/tf-anoa-usgaz-hub-core-dev-vnet"
}

resource "azurerm_virtual_network_peering" "hub_to_aks_spoke" {
  name                      = "hub_to_aks_spoke"
  allow_forwarded_traffic             = true
  allow_virtual_network_access        = true
  #allow_remote_virtual_network_access = true
  resource_group_name       = "tf-anoa-usgaz-hub-core-dev-rg"
  virtual_network_name      = "tf-anoa-usgaz-hub-core-dev-vnet"
  remote_virtual_network_id = "/subscriptions/df79eff1-4ca3-4d21-9c6b-64dd15c253e8/resourceGroups/tf-noops-gov-rg-aks-udr/providers/Microsoft.Network/virtualNetworks/vnet-aks-udr"
}

resource "azurerm_log_analytics_workspace" "aks" {
  name                = "aks-la-01-udr"
  resource_group_name = azurerm_resource_group.aks_rg.name # var.existing_resource_group_name
  location            = module.mod_azure_region_lookup.location_cli
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

resource "azurerm_log_analytics_solution" "solution" {
  solution_name         = "ContainerInsights"
  location              = azurerm_log_analytics_workspace.aks.location
  resource_group_name   = azurerm_log_analytics_workspace.aks.resource_group_name
  workspace_resource_id = azurerm_log_analytics_workspace.aks.id
  workspace_name        = azurerm_log_analytics_workspace.aks.name

  plan {
    publisher = "Microsoft"
    product   = "OMSGallery/ContainerInsights"
  }
} 
