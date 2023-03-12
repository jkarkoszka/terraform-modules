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

# ---------------------------------------------------------------------------------------------------------------------
# OPTIONAL MODULE PARAMETERS
# ---------------------------------------------------------------------------------------------------------------------

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

variable "tags" {
  type        = map(string)
  description = "Any tags that should be present on the resources"
  default     = {}
}
