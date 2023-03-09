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
  description = "The label of the Azure Nat Gateway"
}

variable "public_ips" {
  type        = list(object({ name = string, resource_group_name = string }))
  description = "(Optional) List of Public IP names along with resource group name to be used for NAT Gateway. Max 16."
}

# ---------------------------------------------------------------------------------------------------------------------
# OPTIONAL MODULE PARAMETERS
# ---------------------------------------------------------------------------------------------------------------------

variable "nat_sku_name" {
  type        = string
  description = "(Optional) The SKU which should be used. At this time the only supported value is Standard. Defaults to Standard."
  default     = "Standard"
}

variable "zones" {
  type        = list(string)
  description = "(Optional) Specifies a list of Availability Zones in which this NAT Gateway should be located. Changing this forces a new NAT Gateway to be created."
  default     = []
}

variable "tags" {
  type        = map(string)
  description = "Any tags that should be present on the resources"
  default     = {}
}
