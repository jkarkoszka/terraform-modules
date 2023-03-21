terraform {
  required_version = ">= 1.3.7"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.42"
    }
  }
}

resource "azurerm_kubernetes_cluster" "aks" {
  lifecycle {
    ignore_changes = [
      default_node_pool.0.node_count
    ]
  }

  name                = "${var.prefix}-${var.label}-aks"
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.prefix
  kubernetes_version  = var.kubernetes_version
  node_resource_group = "${var.prefix}-${var.label}-aks-node-rg"

  service_principal {
    client_id = var.service_principal.client_id
    client_secret = var.service_principal.client_secret
  }

  default_node_pool {
    name                 = var.default_node_pool.name
    vnet_subnet_id       = var.default_node_pool.vnet_subnet_id
    min_count            = var.default_node_pool.min_count != null ? var.default_node_pool.min_count : var.default_node_pool_defaults.min_count
    node_count           = var.default_node_pool.node_count != null ? var.default_node_pool.node_count : var.default_node_pool_defaults.node_count
    max_count            = var.default_node_pool.max_count != null ? var.default_node_pool.max_count : var.default_node_pool_defaults.max_count
    vm_size              = var.default_node_pool.vm_size != null ? var.default_node_pool.vm_size : var.default_node_pool_defaults.vm_size
    type                 = var.default_node_pool.type != null ? var.default_node_pool.type : var.default_node_pool_defaults.type
    enable_auto_scaling  = var.default_node_pool.enable_auto_scaling != null ? var.default_node_pool.enable_auto_scaling : var.default_node_pool_defaults.enable_auto_scaling
    zones                = var.default_node_pool.zones != null ? var.default_node_pool.zones : var.default_node_pool_defaults.zones
    orchestrator_version = var.default_node_pool.orchestrator_version != null ? var.default_node_pool.orchestrator_version : var.default_node_pool_defaults.orchestrator_version
    upgrade_settings {
      max_surge = var.default_node_pool.max_surge_on_upgrade != null ? var.default_node_pool.max_surge_on_upgrade : var.default_node_pool_defaults.max_surge_on_upgrade
    }
    tags = var.tags
  }

  network_profile {
    network_plugin     = var.network_plugin
    outbound_type      = var.outbound_type
    load_balancer_sku  = var.load_balancer_sku
    docker_bridge_cidr = var.docker_bridge_cidr
    pod_cidr           = var.pod_cidr
    service_cidr       = var.service_cidr
    dns_service_ip     = var.dns_service_ip
  }

  tags = var.tags
}

resource "azurerm_kubernetes_cluster_node_pool" "node_pool" {
  count = length(var.user_node_pools)

  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks.id
  name                  = var.user_node_pool_defaults[count.index].name
  vnet_subnet_id        = var.user_node_pool_defaults[count.index].vnet_subnet_id
  min_count             = var.user_node_pool_defaults[count.index].min_count != null ? var.user_node_pool_defaults[count.index].min_count : var.user_node_pool_defaults.min_count
  node_count            = var.user_node_pool_defaults[count.index].node_count != null ? var.user_node_pool_defaults[count.index].node_count : var.user_node_pool_defaults.node_count
  max_count             = var.user_node_pool_defaults[count.index].max_count != null ? var.user_node_pool_defaults[count.index].max_count : var.user_node_pool_defaults.max_count
  vm_size               = var.user_node_pool_defaults[count.index].vm_size != null ? var.user_node_pool_defaults[count.index].vm_size : var.user_node_pool_defaults.vm_size
  enable_auto_scaling   = var.user_node_pool_defaults[count.index].enable_auto_scaling != null ? var.user_node_pool_defaults[count.index].enable_auto_scaling : var.user_node_pool_defaults.enable_auto_scaling
  zones                 = var.user_node_pool_defaults[count.index].zones != null ? var.user_node_pool_defaults[count.index].zones : var.user_node_pool_defaults.zones
  orchestrator_version  = var.user_node_pool_defaults[count.index].orchestrator_version != null ? var.user_node_pool_defaults[count.index].orchestrator_version : var.user_node_pool_defaults.orchestrator_version
  upgrade_settings {
    max_surge = var.user_node_pool_defaults[count.index].max_surge_on_upgrade != null ? var.user_node_pool_defaults[count.index].max_surge_on_upgrade : var.user_node_pool_defaults.max_surge_on_upgrade
  }
  tags = var.tags
}
