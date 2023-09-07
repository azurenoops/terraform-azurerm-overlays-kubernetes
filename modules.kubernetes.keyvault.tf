# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

module "mod_key_vault" {
  depends_on = [
    azurerm_user_assigned_identity.aks
  ]
  source                       = "azurenoops/overlays-key-vault/azurerm"
  version                      = "~> 2.0"
  count                        = var.create_aks_keyvault ? 1 : 0
  existing_resource_group_name = local.resource_group_name
  location                     = local.location
  environment                  = var.environment
  deploy_environment           = var.deploy_environment
  org_name                     = var.org_name
  workload_name                = var.workload_name

  # Key Vault Configuration
  sku_name = var.key_vault_sku_name
  enable_purge_protection = var.purge_protection_enabled
  enabled_for_deployment = var.enabled_for_template_deployment

  # Creating Private Endpoint requires, VNet name to create a Private Endpoint
  # By default this will create a `privatelink.vaultcore.azure.net` DNS zone. if created in commercial cloud
  # To use existing subnet, specify `existing_private_subnet_name` with valid subnet name. 
  # To use existing private DNS zone specify `existing_private_dns_zone` with valid zone name.
  enable_private_endpoint      = var.create_aks_keyvault
  virtual_network_name         = var.keyvault_virtual_network_name != null ? var.keyvault_virtual_network_name : null
  existing_private_dns_zone    = var.existing_keyvault_private_dns_zone != null ? var.existing_keyvault_private_dns_zone : null
  existing_private_subnet_name = var.existing_keyvault_private_subnet_name

  # Current user should be here to be able to create keys and secrets
  #admin_objects_ids = [
  #  data.azuread_group.admin_group.id
  #]

  # This is to enable resource locks for the key vault. 
  enable_resource_locks = var.enable_resource_locks

  # Tags for Azure Resources
  add_tags = merge(var.add_tags, local.default_tags)
}

# Create Access Policy for API Service Identity. This is a workaround for the bug in the azurenoops/overlays-key-vault/azurerm module
resource "azurerm_key_vault_access_policy" "aks_access_policy" {
  depends_on = [
    module.mod_key_vault,
    azurerm_user_assigned_identity.aks
  ]
  count = var.create_aks_keyvault && var.identity_type == "UserAssigned" ? 1 : 0
  key_vault_id = module.mod_key_vault.0.key_vault_id
  tenant_id    = data.azurerm_subscription.current.tenant_id
  object_id    = azurerm_user_assigned_identity.aks[0].principal_id

  secret_permissions = [
    "Get",
    "List",
  ]
}
