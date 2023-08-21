variable "location" {
    description = "The Azure Region in which all resources in this example should be created."
    type        = string
    default     = "usgovarizona"
  
}
variable "create_resource_group" {
    description = "Create a new resource group for this example? Set to false to use an existing resource group."
    type        = bool
    default     = true
}

variable "existing_resource_group_name" {
    description = "The name of an existing resource group in which to create all resources in this example."
    type        = string
    default     = "tf-anoa2-usgaz-aks-dev-rg"
}

variable "use_location_short_name" {
    description = "Use the short location name in the resource group name."
    type        = bool
    default     = true
}

variable "org_name" {
    description = "The name of the organization that owns the resource group."
    type        = string
    default     = "AzureNoOps"
}

variable "deploy_environment" {
    description = "The name of the environment (e.g. dev, test, stage, prod)."
    type        = string
    default     = "dev"
}

variable "workload_name" {
    description = "The name of the workload (e.g. myapp)."
    type        = string
    default     = "priv_aks"
}

variable "custom_resource_group_name" {
    description = "A custom name for the resource group. If not specified, a name will be generated."
    type        = string
    default     = null
}

variable "tags" {
    description = "A map of tags to add to all resources in this example."
    type        = map(string)
    default     = {
        "Environment" = "dev"
        "org"         = "anoa"
    }
}
