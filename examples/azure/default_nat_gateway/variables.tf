# ---------------------------------------------------------------------------------------------------------------------
# OPTIONAL MODULE PARAMETERS
# ---------------------------------------------------------------------------------------------------------------------

variable "location" {
  type        = string
  description = "The location of the resources."
  default     = "westeurope"
}

variable "prefix" {
  type        = string
  description = "The prefix used for the name of the resources."
  default     = "tftest"
}

variable "label" {
  type        = string
  description = "The label used for the name eg. $/{prefix/}-$/{label/}-nat-gateway"
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

variable "zones" {
  type        = list(string)
  description = "(Optional) Specifies a list of Availability Zones in which this NAT Gateway should be located. Changing this forces a new NAT Gateway to be created."
  default     = []
}

variable "tags" {
  type        = map(string)
  description = "Any tags that should be present on the resources"
  default     = {
    tfTest = true
  }
}

