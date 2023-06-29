# variables for AKS
variable "aks_name" {
  type = string
  default = "aks"
}
variable "aks_location" {
  type = string
  default = "eastus"
}
variable "aks_resource_group_name" {
  type = string
  default = "aks"
}
variable "kubernetes_version" {
  description = "Kubernetes version to deploy. Will deploy newest AKS version if this value is not set."
  type = string
  default = null 
}

variable "private_dns_zone_type" {
  type = string
  default = "System"
}

variable "private_dns_zone_id" {
  type = string
  default = ""
}
  
variable "log_analytics_workspace_id" {
  type = string
  default = "subscriptions/df79eff1-4ca3-4d21-9c6b-64dd15c253e8/resourceGroups/tf-anoa-usgaz-ops-mgt-logging-dev-rg/providers/Microsoft.OperationalInsights/workspaces/tf-anoa-usgaz-ops-mgt-logging-dev-log"
}

variable "aks_pod_cidr" {
  type = string
  default = ""
}

variable "docker_bridge_cidr" {
  type = string
  default = ""
}

variable "service_cidr" {
  type = string
  default = ""
}

variable "load_balancer_sku" {
  type = string
  default = "Basic"
}

/*
variable "dns_prefix" {
  type = string
  default = "aks.dns.prefix"
}

variable "private_cluster_enabled" {
  type = bool
  default = true
}

variable "automatic_channel_upgrade" {
  type = bool
  default = true
}
variable "sku_tier" {
  type = string
  default = "Free"
}
*/
variable "workload_identity_enabled" {
  type = bool
  default = true
}
variable "oidc_issuer_enabled" {
  type = bool
  default = true
}
variable "open_service_mesh_enabled" {
  type = bool
  default = false
}
variable "image_cleaner_enabled" {
  type = bool
  default = false
}
variable "azure_policy_enabled" {
  type = bool
  default = false 
}
variable "http_application_routing_enabled" {
  type = bool
  default = false
}

variable "default_node_pool" {
  type = object({
    name = string
  })
  default = {
    name = "var.default_node_pool_name"
  }
}

variable "nodes_pools" {
  type = list(string)
  default = []
}

variable "default_node_pool_name" {
  type = string
  default = "default"
}

variable "default_node_pool_type" {
  type = string
  default = "VirtualMachineScaleSets"
}

variable "default_node_pool_vm_size" {
  type = string
  default = "Standard_D2s_v3"
}

variable "vnet_subnet_id" {
  type = string
  default = "/subscriptions/df79eff1-4ca3-4d21-9c6b-64dd15c253e8/resourceGroups/tf-anoa2-usgaz-aks-dev-rg/providers/Microsoft.Network/virtualNetworks/tf-anoa2-usgaz-aks-dev-vnet/subnets/tf-anoa2-usgaz-aks-dev-default-snet"
}

variable "pod_subnet_id" {
  type = string
  default = null
}

variable "nodes_subnet_id" {
  type = string
  default = null
}

variable "default_node_pool_availability_zones" {
  type = list(string)
  default = ["1","2","3"]
}

variable "default_node_pool_node_labels" {
  type = map(string)
  default = {
    "nodepool" = "default"
  }
}

variable "default_node_pool_node_taints" {
  type = list(string)
  default = ["nodepool=default:NoSchedule"]
}

variable "default_node_pool_enable_auto_scaling" {
  type = bool
  default = false
}

variable "default_node_pool_enable_host_encryption" {
  type = bool
  default = true
}

variable "default_node_pool_eviction_policy" {
  type = string
  default = "Delete"
}

variable "default_node_pool_enable_node_public_ip" {
  type = bool
  default = false
}

variable "default_node_pool_max_pods" {
  type = number
  default = 110
}

variable "default_node_pool_max_count" {
  type = number
  default = null
}

variable "default_node_pool_min_count" {
  type = number
  default = null
}

variable "default_node_pool_node_count" {
  type = number
  default = 3
}

variable default_node_pool_os_disk_type {
  type = string
  default = "Managed"
}



variable "default_node_pool_os_disk_size_gb" {
  type = number
  default = 30
}

variable "default_node_pool_os_type" {
  type = string
  default = "managed"
}

variable "default_node_pool_zones" {
  type = list(string)
  default = ["1","2","3"]
}

variable "default_node_pool_orchestrator_version" {
  type = string
  default = "1.24.3"
}

variable "default_node_pool_priority" {
  type = string
  default = "Regular"
}



/*
variable "tags" {
  type = string
  default = "aks"
}
*/

variable "admin_username" {
  type = string
    default = "azureuser"
}
/*
variable "ssh_public_key" {
  type = string
  default = (file("~/.ssh/id_rsa.pub"))
}
*/

  