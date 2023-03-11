# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED MODULE PARAMETERS
# ---------------------------------------------------------------------------------------------------------------------

variable "location" {
  type        = string
  description = "The location of the resources."
}

variable "resource_group_name" {
  type        = string
  description = "The name of your Resource Group"
}

variable "prefix" {
  type        = string
  description = "The label used for the name of the Resource Group eg. $/{prefix/}-$/{label/}-rt"
}

variable "label" {
  type        = string
  description = "The label of the Route table"
}

# ---------------------------------------------------------------------------------------------------------------------
# OPTIONAL MODULE PARAMETERS
# ---------------------------------------------------------------------------------------------------------------------

variable "tags" {
  type        = map(string)
  description = "Any tags that should be present on the resources"
  default     = {}
}
