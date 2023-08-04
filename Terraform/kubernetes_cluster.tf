# module "kubernetes-cluster" {
#   source  = "Retoxx-dev/kubernetes-cluster/azurerm"
#   version = "1.0.0"

#   resource_group_name = azurerm_resource_group.this.name
#   location            = local.location

#   name                = "aks-${local.naming_convention_dash}"
#   dns_prefix          = "aks-${local.naming_convention_dash}"
#   node_resource_group = "rg-${local.naming_convention_dash}-aks-nodes"

#   kubernetes_version = "1.25.6"
#   sku_tier           = "Free"

#   role_based_access_control_enabled = true

#   api_server_access_profile = {
#     authorized_ip_ranges = ["185.157.14.184/32"]
#   }
#   public_network_access_enabled  = true

#   network_profile = {
#     network_plugin = "azure"
#     dns_service_ip = "10.2.0.10"
#     outbound_type  = "loadBalancer"
#     service_cidr   = "10.2.0.0/24"
#   }

#   identity = {
#     name = "aks-${local.naming_convention_dash}"
#   }

#   default_node_pool = {
#     name                   = "default"
#     vm_size                = "standard_B2s"
#     vnet_subnet_id         = module.virtual-network.subnet_ids["snet-${local.naming_convention_dash}-aks"]
#     min_count              = 2
#     max_count              = 3
#     enable_auto_scaling    = true
#     enable_node_public_ip  = false
#     max_pods               = 110
#     orchestrator_version   = "1.25.6"
#   }
# }

# module "kubernetes-cluster-node-pools" {
#   source  = "Retoxx-dev/kubernetes-cluster-node-pools/azurerm"
#   version = "1.0.0"

#   kubernetes_cluster_id = module.kubernetes-cluster.id

#   node_pools = [
#     {
#       name                 = "dev"
#       vnet_subnet_id       = module.virtual-network.subnet_ids["snet-${local.naming_convention_dash}-aks"]
#       vm_size              = "standard_B2s"
#       min_count            = 1
#       max_count            = 2
#       os_disk_size_gb      = 128
#       os_disk_type         = "Managed"
#       max_pods             = 30
#       priority             = "Regular"
#       orchestrator_version = "1.26.3"
#       node_labels = {
#         "env" = "dev"
#       }
#       node_taints = ["env=dev:NoSchedule"]
#     }
#   ]
# }