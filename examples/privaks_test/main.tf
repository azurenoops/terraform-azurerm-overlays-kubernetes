provider "azurerm" {
  features {}
  environment = "AzureUSGovernment"
}

module "azurerm_resource_graph" {
  source  = "Azure/azure-resource-graph/azurerm"
  version = "1.0.0"

  resource_graph_query = "Resources | project name, type | serialize"
}

output "azure_resources" {
  value = module.azure_resource_graph.result
}
