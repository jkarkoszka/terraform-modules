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

variable "subnet_address_prefixes" {
  type        = list(string)
  description = "(Required) The address prefixes to use for the subnet."
  default     = ["10.1.1.0/24"]
}

variable "subnet_label" {
  type        = string
  description = "(Optional) Label used for the subnet name. Defaults to 'main'."
  default     = "main"
}

variable "zone" {
  type        = string
  description = "(Optional) Specifies Availability Zones in which this NAT Gateway should be located. Default to null - no zone. Changing this forces a new NAT Gateway to be created."
  default     = null
}

variable "tags" {
  type        = map(string)
  description = "Any tags that should be present on the resources"
  default     = {}
}
