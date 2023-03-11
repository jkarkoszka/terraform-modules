# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED MODULE PARAMETERS
# ---------------------------------------------------------------------------------------------------------------------

variable "prefix" {
  type        = string
  description = "The prefix"
}

variable "location" {
  type        = string
  description = "The location"
}

variable "resource_group_name" {
  type        = string
  description = "The name of your Resource Group"
}

variable "label" {
  type        = string
  description = "The label"
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

variable "route_table" {
  type        = object({ name = string, resource_group_name = string })
  description = "Route table name along with resource group name. If not null then it's used with new subnet."
  default     = null
}

variable "nat_gateway" {
  type        = object({ name = string, resource_group_name = string })
  description = "NAT Gateway name along with resource group name. If not null then it's used with new subnet."
  default     = null
}

variable "tags" {
  type        = map(string)
  description = "Any tags that should be present on the resources"
  default     = {}
}
