#output "echo_text" {
#  value = module.echo.echo_text
#}

output "vnet_subnet_id" {
  value = azurerm_subnet.aks_subnet_udr_kn.id
}