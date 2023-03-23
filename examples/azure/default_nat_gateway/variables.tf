# ---------------------------------------------------------------------------------------------------------------------
# OPTIONAL MODULE PARAMETERS
# ---------------------------------------------------------------------------------------------------------------------

variable "location" {
  type        = string
  description = "The location."
  default     = "westeurope"
}

variable "prefix" {
  type        = string
  description = "The prefix."
  default     = "tftest"
}

variable "label" {
  type        = string
  description = "The label."
  default     = "abcdfg"
}

variable "public_ip_sku_name" {
  type        = string
  description = "(Optional) The SKU of the Public IP. Accepted values are Basic and Standard. Defaults to Standard. Changing this forces a new resource to be created."
  default     = "Standard"
}

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

variable "number_of_ip_addresses" {
  type        = number
  description = "(Optional) Number of IP addresses for NAT Gateway. Defaults to 1."
  default     = "1"
}

variable "tags" {
  type        = map(string)
  description = "Any tags that should be present on the resources."
  default     = {
    tfTest = true
  }
}

