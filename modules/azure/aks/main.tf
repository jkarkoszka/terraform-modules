terraform {
  required_version = ">= 1.3.7"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.42"
    }
  }
}

locals {
  node_pool_defaults = {
    min_count            = 1
    node_count           = 1
    max_count            = 1
    vm_size              = "Standard_B2ms"
    type                 = "VirtualMachineScaleSets"
    enable_auto_scaling  = true
    zones                = []
    orchestrator_version = "1.24.9"
    max_surge_on_upgrade = "100%"
  }

  user_node_pools = [
    for user_node_pool in var.user_node_pools : {
      name                 = user_node_pool.name
      vnet_subnet_id       = user_node_pool.vnet_subnet_id
      min_count            = user_node_pool.min_count != null ? user_node_pool.min_count : local.node_pool_defaults.min_count
      node_count           = user_node_pool.node_count != null ? user_node_pool.node_count : local.node_pool_defaults.node_count
      max_count            = user_node_pool.max_count != null ? user_node_pool.max_count : local.node_pool_defaults.max_count
      vm_size              = user_node_pool.vm_size != null ? user_node_pool.vm_size : local.node_pool_defaults.vm_size
      type                 = user_node_pool.type != null ? user_node_pool.type : local.node_pool_defaults.type
      enable_auto_scaling  = user_node_pool.enable_auto_scaling != null ? user_node_pool.enable_auto_scaling : local.node_pool_defaults.enable_auto_scaling
      zones                = user_node_pool.zones != null ? user_node_pool.zones : local.node_pool_defaults.zones
      orchestrator_version = user_node_pool.orchestrator_version != null ? user_node_pool.orchestrator_version : local.node_pool_defaults.orchestrator_version
      max_surge_on_upgrade = user_node_pool.max_surge_on_upgrade != null ? user_node_pool.max_surge_on_upgrade : local.node_pool_defaults.max_surge_on_upgrade
    }
  ]
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
    client_id     = var.service_principal.client_id
    client_secret = var.service_principal.client_secret
  }

  default_node_pool {
    name                 = var.default_node_pool.name
    vnet_subnet_id       = var.default_node_pool.vnet_subnet_id
    min_count            = var.default_node_pool.min_count != null ? var.default_node_pool.min_count : local.node_pool_defaults.min_count
    node_count           = var.default_node_pool.node_count != null ? var.default_node_pool.node_count : local.node_pool_defaults.node_count
    max_count            = var.default_node_pool.max_count != null ? var.default_node_pool.max_count : local.node_pool_defaults.max_count
    vm_size              = var.default_node_pool.vm_size != null ? var.default_node_pool.vm_size : local.node_pool_defaults.vm_size
    type                 = var.default_node_pool.type != null ? var.default_node_pool.type : local.node_pool_defaults.type
    enable_auto_scaling  = var.default_node_pool.enable_auto_scaling != null ? var.default_node_pool.enable_auto_scaling : local.node_pool_defaults.enable_auto_scaling
    zones                = var.default_node_pool.zones != null ? var.default_node_pool.zones : local.node_pool_defaults.zones
    orchestrator_version = var.default_node_pool.orchestrator_version != null ? var.default_node_pool.orchestrator_version : local.node_pool_defaults.orchestrator_version
    upgrade_settings {
      max_surge = var.default_node_pool.max_surge_on_upgrade != null ? var.default_node_pool.max_surge_on_upgrade : local.node_pool_defaults.max_surge_on_upgrade
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
  count = length(local.user_node_pools)

  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks.id
  name                  = local.user_node_pools[count.index].name
  vnet_subnet_id        = local.user_node_pools[count.index].vnet_subnet_id
  min_count             = local.user_node_pools[count.index].min_count
  node_count            = local.user_node_pools[count.index].node_count
  max_count             = local.user_node_pools[count.index].max_count
  vm_size               = local.user_node_pools[count.index].vm_size
  enable_auto_scaling   = local.user_node_pools[count.index].enable_auto_scaling
  zones                 = local.user_node_pools[count.index].zones
  orchestrator_version  = local.user_node_pools[count.index].orchestrator_version
  upgrade_settings {
    max_surge = local.user_node_pools[count.index].max_surge_on_upgrade
  }
  tags = var.tags
}
