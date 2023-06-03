variable "existing_resource_group_name" {
  description = "The name of the existing resource group to use. If not set, the name will be generated using the `org_name`, `workload_name`, `deploy_environment` and `environment` variables."
  type        = string
  default     = null
}
# AKS variables
variable "aks_location" {
  description = "The location of the AKS cluster."
  type        = string
  default     = "usgovarizona"
}
variable "aks_environment" {
  description = "The environment of the AKS cluster."
  type        = string
  default     = "usgovernment"
}
variable "aks_org_name" {
    description = "The organization name of the AKS cluster."
    type        = string
    default     = "tf-anoa"
}
variable "aks_workload_name" {
    description = "The workload name of the AKS cluster."
    type        = string
    default     = "priv_aks"
}
variable "aks_deploy_environment" {
    description = "The deployment environment of the AKS cluster."
    type        = string
    default     = "dev"
}

variable "aks_name" {
  description = "The name of the AKS cluster."
  type        = string
  default     = "priv-aks-gov"
}  
variable "aks_version" {
  description = "The version of Kubernetes to use for the AKS cluster."
  type        = string
  default     = "1.25.6"
}
variable "aks_version_prefix" {
  description = "The version prefix of Kubernetes to use for the AKS cluster."
  type        = string
  default     = "1.25"
}
variable "aks_resourse_group_name" {
  description = "The name of the resource group to create for the AKS cluster."
  type        = string
  default     = "tf-anoa-usgaz-priv_aks-dev-rg"
                
}
variable "aks_default_node_pool_name" {
  description = "The name of the default node pool."
  type        = string
  default     = "default"
}
variable "aks_default_node_count" {
  description = "The number of nodes in the default node pool."
  type        = number
  default     = 3
}
variable "aks_default_node_vm_size" {
  description = "The size of the VMs in the default node pool."
  type        = string
  default     = "Standard_D2s_v3"
}

  

