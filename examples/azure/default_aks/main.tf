module "rg" {
  source = "../../../modules/azure/rg"

  location = var.location
  prefix   = var.prefix
  label    = var.label
}

module "default_aks" {
  source = "../../../modules/azure/default_aks"

  location                = var.location
  resource_group_name     = module.rg.name
  prefix                  = var.prefix
  label                   = var.label
  vnet_address_space      = var.vnet_address_space
  subnet_address_prefixes = var.subnet_address_prefixes
  subnet_label            = var.subnet_label
  zone                    = var.zone
  kubernetes_version      = var.kubernetes_version
  network_plugin          = var.network_plugin
  outbound_type           = var.outbound_type
  load_balancer_sku       = var.load_balancer_sku
  docker_bridge_cidr      = var.docker_bridge_cidr
  pod_cidr                = var.pod_cidr
  service_cidr            = var.service_cidr
  dns_service_ip          = var.dns_service_ip
  user_node_pools         = var.user_node_pools
  tags                    = var.tags
}
