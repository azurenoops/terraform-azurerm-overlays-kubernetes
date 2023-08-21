# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

#---------------------------------------------------------------
# Azure Kubernetes Service (AKS) Cluster
#----------------------------------------------------------------
<<<<<<< HEAD

## *** 
resource "azurerm_kubernetes_cluster" "aks_cluster" {
  # depends_on = [
  #   azurerm_role_assignment.aks_uai_private_dns_zone_contributor,
  #   azurerm_role_assignment.aks_uai_route_table_contributor,
  # ]

  name                = local.cluster_name
  location            = local.location
  resource_group_name = local.resource_group_name
  kubernetes_version  = var.kubernetes_version

  node_resource_group = local.node_resource_group



  private_cluster_enabled       = true  // private cluster is always enabled based on the current implementation (SCCA)
  public_network_access_enabled = false // public network access is always disabled based on the current implementation (SCCA)
  sku_tier                      = var.sku_tier

  private_dns_zone_id = local.private_dns_zone_id
  #  dns_prefix_private_cluster = local.dns_prefix
  dns_prefix = local.dns_prefix

  network_profile {
    network_plugin     = var.network_plugin
    network_policy     = var.network_policy
    dns_service_ip     = (var.network_profile_options == null ? null : var.network_profile_options.dns_service_ip)
    docker_bridge_cidr = (var.network_profile_options == null ? null : var.network_profile_options.docker_bridge_cidr)
    service_cidr       = (var.network_profile_options == null ? null : var.network_profile_options.service_cidr)
    outbound_type      = var.outbound_type
    pod_cidr           = (var.network_plugin == "kubenet" ? var.pod_cidr : null)
  }

  default_node_pool {
    name                         = var.default_node_pool_name
    vm_size                      = local.node_pools[var.default_node_pool_name].vm_size
    os_disk_size_gb              = local.node_pools[var.default_node_pool_name].os_disk_size_gb
    os_disk_type                 = local.node_pools[var.default_node_pool_name].os_disk_type
    enable_auto_scaling          = local.node_pools[var.default_node_pool_name].enable_auto_scaling
    node_count                   = (local.node_pools[var.default_node_pool_name].enable_auto_scaling ? null : local.node_pools[var.default_node_pool_name].node_count)
    min_count                    = (local.node_pools[var.default_node_pool_name].enable_auto_scaling ? local.node_pools[var.default_node_pool_name].min_count : null)
    max_count                    = (local.node_pools[var.default_node_pool_name].enable_auto_scaling ? local.node_pools[var.default_node_pool_name].max_count : null)
    enable_host_encryption       = local.node_pools[var.default_node_pool_name].enable_host_encryption
    enable_node_public_ip        = local.node_pools[var.default_node_pool_name].enable_node_public_ip
    type                         = local.node_pools[var.default_node_pool_name].type
    only_critical_addons_enabled = local.node_pools[var.default_node_pool_name].only_critical_addons_enabled
    orchestrator_version         = local.node_pools[var.default_node_pool_name].orchestrator_version
    max_pods                     = local.node_pools[var.default_node_pool_name].max_pods
    node_labels                  = local.node_pools[var.default_node_pool_name].node_labels
    tags                         = local.node_pools[var.default_node_pool_name].tags
    vnet_subnet_id = (local.node_pools[var.default_node_pool_name].subnet != null ?
    var.virtual_network.subnets[local.node_pools[var.default_node_pool_name].subnet].id : null)

    upgrade_settings {
      max_surge = local.node_pools[var.default_node_pool_name].max_surge
=======
resource "azurerm_kubernetes_cluster" "aks_cluster" {
  location                         = local.location
  resource_group_name              = local.resource_group_name
  name                             = local.aks_name
  kubernetes_version               = local.aks_version
  dns_prefix                       = var.dns_prefix
  private_cluster_enabled          = var.private_cluster_enabled
  automatic_channel_upgrade        = var.automatic_channel_upgrade
  sku_tier                         = var.sku_tier
  workload_identity_enabled        = var.workload_identity_enabled
  oidc_issuer_enabled              = var.oidc_issuer_enabled
  open_service_mesh_enabled        = var.open_service_mesh_enabled
  image_cleaner_enabled            = var.image_cleaner_enabled
  azure_policy_enabled             = var.azure_policy_enabled
  
  default_node_pool {
    name                    = var.default_node_pool_name
    node_count              = var.default_node_pool_node_count
    vm_size                 = var.default_node_pool_vm_size
    vnet_subnet_id          = var.vnet_subnet_id
    pod_subnet_id           = var.pod_subnet_id
    #zones                   = var.default_node_pool_availability_zones
    #node_labels             = var.default_node_pool_node_labels
    #node_taints             = var.default_node_pool_node_taints
    #enable_auto_scaling     = var.default_node_pool_enable_auto_scaling
    #enable_host_encryption  = var.default_node_pool_enable_host_encryption
    #enable_node_public_ip   = var.default_node_pool_enable_node_public_ip
    #max_pods                = var.default_node_pool_max_pods
    #max_count               = var.default_node_pool_max_count
    #min_count               = var.default_node_pool_min_count
    #os_disk_type            = var.default_node_pool_os_disk_type
    #tags                    = var.tags
  }

/*
  linux_profile {
    admin_username = var.admin_username
    
    ssh_key {
       key_data = data.azurerm_kubernetes_cluster.aks_cluster.linux_profile.0.ssh_key.0.key_data
                  #var.ssh_public_key
>>>>>>> f86e8078fb190ed2e7b3c954c286a25e72bfab98
    }
    
  }
  */

  identity {
    type = var.identity_type
    identity_ids = (var.identity_type == "SystemAssigned" ? null :
      (var.user_assigned_identity != null ?
        [var.user_assigned_identity.id] :
    [azurerm_user_assigned_identity.aks.0.id]))
  }

<<<<<<< HEAD
  api_server_authorized_ip_ranges = local.api_server_authorized_ip_ranges

  /* oms_agent {
    log_analytics_workspace_id = var.log_analytics_workspace_id
  } */

  azure_policy_enabled = var.azure_policy_enabled

  dynamic "windows_profile" {
    for_each = local.windows_nodes ? [1] : []
    content {
      admin_username = var.windows_profile.admin_username
      admin_password = var.windows_profile.admin_password
    }
  }

  dynamic "key_vault_secrets_provider" {
    for_each = var.key_vault_secrets_provider[*]
    content {
      secret_rotation_enabled  = key_vault_secrets_provider.value.secret_rotation_enabled
      secret_rotation_interval = key_vault_secrets_provider.value.secret_rotation_interval
    }
  }

  dynamic "ingress_application_gateway" {
    for_each = try(var.ingress_application_gateway.gateway_id, null) == null ? [] : [1]

    content {
      gateway_id  = var.ingress_application_gateway.gateway_id
      subnet_cidr = var.ingress_application_gateway.subnet_cidr
      subnet_id   = var.ingress_application_gateway.subnet_id
    }
  }

  tags = merge(local.default_tags, var.add_tags)
=======
  network_profile {
    dns_service_ip     = var.network_dns_service_ip
    network_plugin     = var.network_plugin
    network_policy     = var.network_policy
    outbound_type      = var.outbound_type
    service_cidr       = var.network_service_cidr
  }

    oms_agent {
    msi_auth_for_monitoring_enabled = true
    log_analytics_workspace_id      = var.log_analytics_workspace_id #coalesce(var.oms_agent.log_analytics_workspace_id, var.log_analytics_workspace_id)
  }
  azure_active_directory_role_based_access_control {
    managed                    = true
    tenant_id                  = var.tenant_id
    admin_group_object_ids     = var.admin_group_object_ids
    azure_rbac_enabled         = var.azure_rbac_enabled
  }

  workload_autoscaler_profile {
    keda_enabled                    = var.keda_enabled
    vertical_pod_autoscaler_enabled = var.vertical_pod_autoscaler_enabled
  }
>>>>>>> f86e8078fb190ed2e7b3c954c286a25e72bfab98

  lifecycle {
    ignore_changes = [
      kubernetes_version,
      tags
    ]
  }
}
