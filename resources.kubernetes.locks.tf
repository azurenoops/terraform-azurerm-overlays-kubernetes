# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

#------------------------------------------------------------
# Resource Group Lock configuration - Remove if not needed 
#------------------------------------------------------------
resource "azurerm_management_lock" "resource_group_level_lock" {
  count      = var.enable_resource_locks ? 1 : 0
  
  name       = "${local.rg_name}-${var.lock_level}-lock"
  scope      = azurerm_resource_group.main_rg.id
  lock_level = var.lock_level
  notes      = "Resource Group '${local.rg_name}' is locked with '${var.lock_level}' level."
}

#------------------------------------------------------------
# Kubernetes Lock configuration - Remove if not needed 
#------------------------------------------------------------
resource "azurerm_management_lock" "kubernetes_level_lock" {
  count      = var.enable_resource_locks ? 1 : 0
  
  name       = "${var.name}-${var.lock_level}-lock"
  scope      = azurerm_kubernetes_cluster.aks_cluster.id
  lock_level = var.lock_level
  notes      = "Azure Kubernetes Cluster '${var.name}' is locked with '${var.lock_level}' level."
}
