# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

locals {
  default_agent_profile = {
    name                   = var.default_node_pool_name
    node_count             = var.default_node_pool_node_count
    vm_size                = var.default_node_pool_vm_size
    os_type                = var.default_node_pool_os_type
    zones                  = var.default_node_pool_zones
    enable_auto_scaling    = var.default_node_pool_enable_auto_scaling
    min_count              = var.default_node_pool_min_count
    max_count              = var.default_node_pool_max_count
    type                   = var.default_node_pool_type
    node_taints            = var.default_node_pool_node_taints
    node_labels            = var.default_node_pool_node_labels
    orchestrator_version   = var.default_node_pool_orchestrator_version
    priority               = var.default_node_pool_priority
    enable_host_encryption = var.default_node_pool_enable_host_encryption
    eviction_policy        = var.default_node_pool_eviction_policy
    vnet_subnet_id         = var.vnet_subnet_id
    pod_subnet_id          = var.pod_subnet_id
    max_pods               = var.default_node_pool_max_pods
    os_disk_type           = var.default_node_pool_os_disk_type
    os_disk_size_gb        = var.default_node_pool_os_disk_size_gb
    enable_node_public_ip  = var.default_node_pool_enable_node_public_ip
  }

  # Defaults for Linux profile
  # Generally smaller images so can run more pods and require smaller HD
  default_linux_node_profile = {
    max_pods        = 30
    os_disk_size_gb = 128
  }

  # Defaults for Windows profile
  # Do not want to run same number of pods and some images can be quite large
  default_windows_node_profile = {
    max_pods        = 20
    os_disk_size_gb = 256
  }

  default_node_pool = merge(local.default_agent_profile, var.default_node_pool)

  nodes_pools_with_defaults = [for ap in var.nodes_pools : merge(local.default_agent_profile, ap)]
  nodes_pools               = [for ap in local.nodes_pools_with_defaults : ap.os_type == "Linux" ? merge(local.default_linux_node_profile, ap) : merge(local.default_windows_node_profile, ap)]

  private_dns_zone              = var.private_dns_zone_type == "Custom" ? var.private_dns_zone_id : var.private_dns_zone_type
  is_custom_dns_private_cluster = var.private_dns_zone_type == "Custom" && var.private_cluster_enabled

  load_balancer_sku = var.load_balancer_sku
/*
  default_no_proxy_url_list = [
    data.azurerm_virtual_network.aks_vnet[*].address_space,
    var.aks_pod_cidr,
    var.docker_bridge_cidr,
    var.service_cidr,
    "localhost",
    "konnectivity",
    "127.0.0.1",       # Localhost
    "168.63.129.16",   # Azure platform global VIP (https://learn.microsoft.com/en-us/azure/virtual-network/what-is-ip-address-168-63-129-16)
    "169.254.169.254", # Azure Instance Metadata Service (IMDS)
  ]
  */
#if customer set a kubernets version then use that, else use the latest version available in AKS
aks_version = coalesce(var.kubernetes_version, data.azurerm_kubernetes_service_versions.current.latest_version)

log_analytics_workspace_id = var.log_analytics_workspace_id != "" ? var.log_analytics_workspace_id : null


}
