variable "aks_admin_group_object_ids" {
  description = "aks admin group ids"
  type        = list(string)
  default     = [ "5717be51-fa3a-4ac7-9683-d3807471ab4b" ]
 # default     = [ "9e85f28d-5dcf-4861-9834-4105edaffd23" ]
  
}

variable "azure_ad_rbac_enabled" {
  description = "Controls if the AD and RBAC should be enabled. If set to true, the AD and RBAC will be enabled. Default is false."
  type        = bool
  default     = false
}

variable "aks_user_group" {
  default = "AKS Application Dev. Team"
}

variable "aks_admin_group" {
  default = "AKS Admin Team"
}

variable "aks_ops_group" {
  default = "AKS Operations Team"
}

variable "aks_reader_group" {
  default = "AKS Reader Role Team"
}

variable "aks_writer_group" {
  default = "AKS Writer Role Team"
}

