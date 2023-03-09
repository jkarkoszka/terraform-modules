# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED MODULE PARAMETERS
# ---------------------------------------------------------------------------------------------------------------------

variable "prefix" {
  type        = string
  description = "The prefix for the resources created in the specified Azure Resource Group"
}

variable "location" {
  type        = string
  description = "The location of your Resource Group"
}

variable "resource_group_name" {
  type        = string
  description = "The name of your Resource Group"
}

variable "label" {
  type        = string
  description = "The label of the subnet of the Azure virtual network"
}

variable "vnet_name" {
  type        = string
  description = "The name of the Azure virtual network"
}

variable "address_prefixes" {
  type        = list(string)
  description = "(Required) The address prefixes to use for the subnet."
}

# ---------------------------------------------------------------------------------------------------------------------
# OPTIONAL MODULE PARAMETERS
# ---------------------------------------------------------------------------------------------------------------------

variable "external_route_table" {
  type        = object({ name = string, resource_group_name = string })
  description = "Route table - if passed then it's used instead of creating new"
  default     = null
}

variable "create_route_table" {
  type        = bool
  description = "If the route table should be created"
  default     = true
}

variable "external_nat_gateway" {
  type        = object({ name = string, resource_group_name = string })
  description = "NAT Gateway - if passed then it's used instead of creating new"
  default     = null
}

variable "create_nat_gateway" {
  type        = bool
  description = "If the NAT Gateway should be created"
  default     = true
}

variable "tags" {
  type        = map(string)
  description = "Any tags that should be present on the resources"
  default     = {}
}
