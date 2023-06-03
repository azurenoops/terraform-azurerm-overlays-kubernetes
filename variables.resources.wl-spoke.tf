variable "existing_resource_group_name" {
  description = "The name of the existing resource group to use. If not set, the name will be generated using the `org_name`, `workload_name`, `deploy_environment` and `environment` variables."
  type        = string
  default     = null
}

# AKS vNet | spoke variables
variable "aks_vnet_location" {
  description = "The location of the AKS cluster."
  type        = string
  default     = "usgovarizona"
}
variable "aks_vnet_environment" {
  description = "The environment of the AKS cluster."
  type        = string
  default     = "usgovernment"
}
variable "aks_vnet_org_name" {
    description = "The organization name of the AKS cluster."
    type        = string
    default     = "tf-anoa"
}
variable "aks_vnet_workload_name" {
    description = "The workload name of the AKS cluster."
    type        = string
    default     = "priv_aks"
}
variable "aks_deploy_environment" {
    description = "The deployment environment of the AKS cluster."
    type        = string
    default     = "dev"
}
/*
variable "aks_vnet_resourse_group_name" {
  description = "The name of the resource group to create for the AKS cluster."
  type        = string
  default     = "tf-anoa-usgaz-priv_aks-dev-rg"               
}
*/