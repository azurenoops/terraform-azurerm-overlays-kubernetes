# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

module "kubernetes" {
  source = "../.."
  
  location            = module.mod_azure_region_lookup.location_cli
  resource_group_name = module.resource_group.name

  identity_type = "UserAssigned"

  network_plugin = "kubenet"

  configure_network_role = true

  virtual_network = {
    subnets = {
      private = {
        id = module.mod_workload_network.subnets["iaas-private"].id
      }
      public = {
        id = module.virtual_network.subnets["iaas-public"].id
      }
    }
    route_table_id = module.virtual_network.route_tables["aks"].id
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
