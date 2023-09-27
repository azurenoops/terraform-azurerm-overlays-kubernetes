# Azurerm provider configuration
provider "azurerm" {
  environment                = "USGovernment"
  skip_provider_registration = "true"
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}


data "azurerm_role_assignment" "example" {
  principal_id = "<PRINCIPAL_ID>"  # Replace with the principal's ID you want to check
  role_definition_name = "Contributor"  # Replace with the role name you want to check
  scope = "/subscriptions/<SUBSCRIPTION_ID>/resourceGroups/<RESOURCE_GROUP_NAME>"  # Replace with the scope of the role assignment
}

output "role_assignment_exists" {
  value = data.azurerm_role_assignment.example.id != null
}
