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
  new_subnet_name = "${var.prefix}-${var.label}-subnet"

  create_new_route_table   = var.create_route_table && var.external_route_table == null
  use_external_route_table = !var.create_route_table && var.external_route_table != null

  create_new_nat_gateway   = var.create_nat_gateway && var.external_nat_gateway == null
  use_external_nat_gateway = !var.create_nat_gateway && var.external_nat_gateway != null

  new_nat_gateway_id      = local.create_new_nat_gateway ? module.new_nat_gateway[0].id : ""
  external_nat_gateway_id = local.use_external_nat_gateway ? data.azurerm_nat_gateway.external_nat_gateway[0].id : ""
  nat_gateway_id          = coalesce(local.new_nat_gateway_id, local.external_nat_gateway_id)

  new_nat_gateway_name      = local.create_new_nat_gateway ? module.new_nat_gateway[0].name : ""
  external_nat_gateway_name = local.use_external_nat_gateway ? data.azurerm_nat_gateway.external_nat_gateway[0].name : ""
  nat_gateway_name          = coalesce(local.new_nat_gateway_name, local.external_nat_gateway_name)

  new_nat_gateway_rg      = local.create_new_nat_gateway ? module.new_nat_gateway[0].resource_group_name : ""
  external_nat_gateway_rg = local.use_external_nat_gateway ? data.azurerm_nat_gateway.external_nat_gateway[0].resource_group_name : ""
  nat_gateway_rg          = coalesce(local.new_nat_gateway_rg, local.external_nat_gateway_rg)

  nat_gateway_public_ips = data.azurerm_nat_gateway.external_nat_gateway[0].public_ip_address_ids

}

resource "azurerm_subnet" "subnet" {
  name                 = local.new_subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.vnet_name
  address_prefixes     = var.address_prefixes
}

# Route table (new or external or none)
resource "azurerm_route_table" "new_rt" {
  count               = local.create_new_route_table ? 1 : 0
  name                = "${local.new_subnet_name}-rt"
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

resource "azurerm_subnet_route_table_association" "subnet_to_new_rt" {
  count          = local.create_new_route_table ? 1 : 0
  subnet_id      = azurerm_subnet.subnet.id
  route_table_id = azurerm_route_table.new_rt[count.index].id
}

data "azurerm_route_table" "external_rt" {
  count               = local.use_external_route_table ? 1 : 0
  name                = var.external_route_table.name
  resource_group_name = var.external_route_table.resource_group_name
}

resource "azurerm_subnet_route_table_association" "subnet_to_external_rt" {
  count          = local.use_external_route_table ? 1 : 0
  subnet_id      = azurerm_subnet.subnet.id
  route_table_id = data.azurerm_route_table.external_rt[count.index].id
}

# NAT Gateway
module "new_nat_gateway" {
  count  = local.create_new_nat_gateway ? 1 : 0
  source = "../nat_gateway"

  resource_group_name     = var.resource_group_name
  prefix                  = var.prefix
  location                = var.location
  name                    = "no-zone"
  create_public_ips_count = 1
}

resource "azurerm_subnet_nat_gateway_association" "subnet_to_new_nat_gateway" {
  count          = local.create_new_nat_gateway ? 1 : 0
  subnet_id      = azurerm_subnet.subnet.id
  nat_gateway_id = module.new_nat_gateway[count.index].id
}

data "azurerm_nat_gateway" "external_nat_gateway" {
  count               = local.use_external_nat_gateway ? 1 : 0
  name                = var.external_nat_gateway.name
  resource_group_name = var.external_nat_gateway.resource_group_name
}

resource "azurerm_subnet_nat_gateway_association" "subnet_to_external_nat_gateway" {
  count          = local.use_external_nat_gateway ? 1 : 0
  subnet_id      = azurerm_subnet.subnet.id
  nat_gateway_id = data.azurerm_nat_gateway.external_nat_gateway[count.index].id
}

