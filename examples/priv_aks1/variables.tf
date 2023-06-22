variable "location" {
    type = string
    default = "usgovarizona"
}

variable "existing_resource_group_name" {
    type = string
    default = "tf-anoa2-usgaz-aks-dev-rg"
}

variable "org_name" {
    type = string
    default = "anoa"
}

variable "workload_name" {
    type = string
    default = "priv_aks1"
  
}

variable "deploy_environment" {
    type = string
    default = "dev"
}
