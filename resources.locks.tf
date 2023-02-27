# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

#------------------------------------------------------------
# Kubernetes Lock configuration - Default (required). 
#------------------------------------------------------------
resource "azurerm_management_lock" "vnet_resource_group_level_lock" {
  count      = var.enable_resource_locks ? 1 : 0
  name       = "${local.aks_name}-${var.lock_level}-lock"
  scope      = azurerm_kubernetes_cluster.aks.id
  lock_level = var.lock_level
  notes      = "Azure Kubernetes Cluster: '${local.aks_name}' is locked with '${var.lock_level}' level."
}