#output "echo_text" {
#  value = module.echo.echo_text
#}

output "azurerm_subnet_aks_subnet_id" {
    value = azurerm_subnet.aks_subnet.id
  
}