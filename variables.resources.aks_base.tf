variable "aks_location" {
  type = string
  default = "usgovarizona"
}

variable "aks_version_prefix" {
  type = string
  default = "1.25"
}

variable "aks_name" {
  type = string
  default = "priv-aks"
}

variable "aks_version" {
  type = string
  default = "1.25.6"
}

variable "aks_prive_cluster_enabled" {
  type = bool
  default = true
}

variable "aks_network_profile_network_plugin" {
  type = map
  default = {
    network_plugin = "azure"
    network_policy = "calico"
  }
}

variable "aks_default_node_pool_name" {
  type = string
  default = "default"
}

variable "aks_default_node_count" {
  type = number
  default = 1
}

variable "aks_default_node_enable_auto_scaling" {
  type = bool
  default = true
}

variable "aks_default_node_vm_size" {
  type = string
  default = "Standard_D2s_v3"
}

variable "aks_default_node_max_pods" {
  type = number
  default = 110
}

variable "aks_default_node_max_count" {
  type = number
  default = 3
}

variable "default_node_pool_min_count" {
  type = number
  default = 1
}

variable "default_node_pool_os_type" {
  type = string
  default = "Managed"
}

variable "tags" {
  type = map(string)
  default = {
    "Environment" = "dev"
    "org"         = "anoa"
  }
}

#linux_profile 
variable "admin_username" {
  description = "(Required) Specifies the Admin Username for the AKS cluster worker nodes. Changing this forces a new resource to be created."
  type        = string
  default     = "azadmin"
}

variable "ssh_public_key" {
  description = "(Required) Specifies the SSH public key used to access the cluster. Changing this forces a new resource to be created."
  type        = string
  default     = null 
}

variable "network_dns_service_ip" {
  description = "Specifies the DNS service IP"
  default     = "10.2.0.10"
  type        = string
}
variable "network_plugin" {
  description = "Specifies the network plugin of the AKS cluster"
  default     = "azure"
  type        = string
}
variable "outbound_type" {
  description = "(Optional) The outbound (egress) routing method which should be used for this Kubernetes Cluster. Possible values are loadBalancer and userDefinedRouting. Defaults to loadBalancer."
  type        = string
  default     = "userDefinedRouting"

  validation {
    condition = contains(["loadBalancer", "userDefinedRouting"], var.outbound_type)
    error_message = "The outbound type is invalid."
  }
}
variable "network_service_cidr" {
  description = "Specifies the service CIDR"
  default     = "10.2.0.0/24"
  type        = string
}
#oms agent
variable "oms_agent" {
  description = "Specifies the OMS agent addon configuration."
  type        = object({
    enabled                     = bool           
    log_analytics_workspace_id  = string
  })
  default     = {
    enabled                     = true
    log_analytics_workspace_id  = null
  }
}

#AAD rbac 
variable "tenant_id" {
  description = "(Required) The tenant id of the system assigned identity which is used by master components."
  type        = string
  default     = null
}

variable "admin_group_object_ids" {
  description = "(Optional) A list of Object IDs of Azure Active Directory Groups which should have Admin Role on the Cluster."
  default     = []
  type        = list(string)
}

variable "azure_rbac_enabled" {
  description = "(Required) Is Role Based Access Control Enabled? Changing this forces a new resource to be created."
  default     = true
  type        = bool
}

variable "keda_enabled" {
  description = "(Optional) Specifies whether KEDA Autoscaler can be used for workloads."
  type        = bool
  default     = false 
}

variable "vertical_pod_autoscaler_enabled" {
  description = "(Optional) Specifies whether Vertical Pod Autoscaler should be enabled."
  type        = bool
  default     = true
}