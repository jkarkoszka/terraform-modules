# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED MODULE PARAMETERS
# ---------------------------------------------------------------------------------------------------------------------

variable "prefix" {
  type        = string
  description = "The prefix."
}

variable "location" {
  type        = string
  description = "The location."
}

variable "resource_group_name" {
  type        = string
  description = "The name of your Resource Group."
}

variable "label" {
  type        = string
  description = "The label."
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

variable "zone" {
  type        = string
  description = "(Optional) Specifies Availability Zones in which this NAT Gateway should be located. Default to null - no zone. Changing this forces a new NAT Gateway to be created."
  default     = null
}

variable "tags" {
  type        = map(string)
  description = "Any tags that should be present on the resources."
  default     = {}
}
