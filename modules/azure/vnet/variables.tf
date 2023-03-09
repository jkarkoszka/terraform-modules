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
  description = "The label of the Azure virtual network"
}

# ---------------------------------------------------------------------------------------------------------------------
# OPTIONAL MODULE PARAMETERS
# ---------------------------------------------------------------------------------------------------------------------

variable "vnet_address_space" {
  type        = list(string)
  description = "The address space to be used for the Azure virtual network."
  default     = ["10.1.0.0/16"]
}

variable "subnets" {
  type = list(object({
    label                = string
    address_prefixes     = list(string)
    create_route_table   = bool
    external_route_table = optional(object({ name = string, resource_group_name = string }))
    create_nat_gateway   = bool
    external_nat_gateway = optional(object({ name = string, resource_group_name = string }))
  }))
  description = "A list of Subnet Prefixes to use along with subnet names"
  default     = [
    {
      label                = "main"
      address_prefixes     = ["10.1.1.0/24"]
      create_route_table   = true
      external_route_table = null
      create_nat_gateway   = true
      external_nat_gateway = null
    }
  ]
}

variable "tags" {
  type        = map(string)
  description = "Any tags that should be present on the resources"
  default     = {}
}
