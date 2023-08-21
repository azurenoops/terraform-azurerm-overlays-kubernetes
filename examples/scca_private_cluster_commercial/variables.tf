
variable "location" {
  type    = string
  default = "eastus"
}

# variable string we use Automating naming convention. Orgname=BC-, 
variable "org_name" {
  type    = string
  default = "tf-noops"
}

# AKS workload name using naming convention.. BC-AKS-USGV-dev. 
variable "workload_name" {
  type    = string
  default = ""

}

# deploy_environment used which Azure Cloud - Test/UAT/Dev/Prod etc.. 
variable "deploy_environment" {
  type    = string
  default = "dev"
}

# Env used which Azure Cloud - Gov/Public etc.. 
variable "environment" {
  type    = string
  default = "dev"
}

# Network policy AKS
variable "network_plugin" {
  type    = string
  default = "azure"
}


variable "network_policy" {
  type    = string
  default = "calico"
}

