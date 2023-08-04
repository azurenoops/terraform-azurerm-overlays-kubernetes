# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

module "kubernetes" {
  source     = "../.."
  depends_on = [module.mod_workload_network]
  
  environment = var.environment
  deploy_environment = var.deploy_environment
  org_name = var.org_name
  workload_name = "aks"
  location = var.location

  identity_type = "UserAssigned"

  network_plugin = "kubenet"

  configure_network_role = true

  virtual_network = {
    subnets = {
      private = {
        id = module.mod_workload_network.subnet_ids["iaas-private"].id
      }
      public = {
        id = module.mod_workload_network.subnet_ids["iaas-public"].id
      }
    }
    route_table_id = module.mod_workload_network.route_table_id
  }

  node_pools = {
    system = {
      vm_size                      = "Standard_B2s"
      node_count                   = 2
      only_critical_addons_enabled = true
      subnet                       = "private"
    }
    linuxweb = {
      vm_size             = "Standard_B2ms"
      enable_auto_scaling = true
      min_count           = 1
      max_count           = 3
      subnet              = "public"
    }
    winweb = {
      vm_size             = "Standard_D4a_v4"
      os_type             = "Windows"
      enable_auto_scaling = true
      min_count           = 1
      max_count           = 3
      subnet              = "public"
    }
  }

  default_node_pool_name = "system"
}
