# ---------------------------------------------------------------------------------------------------------------------
# OPTIONAL MODULE PARAMETERS
# ---------------------------------------------------------------------------------------------------------------------

variable "location" {
  type        = string
  description = "The location"
  default     = "westeurope"
}

variable "prefix" {
  type        = string
  description = "The prefix"
  default     = "tftest"
}

variable "label" {
  type        = string
  description = "The vnet label"
  default     = "abcdfg"
}

variable "vnet_address_space" {
  type        = list(string)
  description = "The address space to be used for the Azure Virtual Network."
  default     = ["10.1.0.0/16"]
}

variable "subnets" {
  type = list(object({
    label            = string
    address_prefixes = list(string)
    route_table      = optional(object({ name = string, resource_group_name = string }))
    nat_gateway      = optional(object({ name = string, resource_group_name = string }))
    nsg              = optional(object({ name = string, resource_group_name = string }))
  }))
  description = "A list of subnets to create within the Azure Virtual Network"
  default     = [
    {
      label            = "main"
      address_prefixes = ["10.1.1.0/24"]
      route_table      = null
      nat_gateway      = null
      nsg              = null
    }
  ]
}

variable "create_route_table" {
  type        = bool
  description = "If Route Table should be created and attached to subnet."
  default     = false
}

variable "create_nat_gateway" {
  type        = bool
  description = "If NAT Gateway should be created and attached to subnet."
  default     = false
}

variable "create_nsg" {
  type        = bool
  description = "If Network Security Group should be created and attached to subnet."
  default     = false
}

variable "public_ip_sku_name" {
  type        = string
  description = "(Optional) The SKU of the Public IP. Accepted values are Basic and Standard. Defaults to Standard. Only used when NAT Gateway is created. Changing this forces a new resource to be created."
  default     = "Standard"
}

variable "nat_sku_name" {
  type        = string
  description = "(Optional) The SKU which should be used. At this time the only supported value is Standard. Defaults to Standard. Only used when NAT Gateway is created."
  default     = "Standard"
}

variable "zones" {
  type        = list(string)
  description = "(Optional) Specifies a list of Availability Zones in which this NAT Gateway and/or Route Table should be located. Only used when NAT Gateway or Route table is created. Changing this forces a new NAT Gateway and/or Route Table to be created."
  default     = []
}

variable "tags" {
  type        = map(string)
  description = "Any tags that should be present on the resources"
  default     = {
    tfTest = true
  }
}
