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

variable "label" {
  type        = string
  description = "The label."
}

# ---------------------------------------------------------------------------------------------------------------------
# OPTIONAL MODULE PARAMETERS
# ---------------------------------------------------------------------------------------------------------------------

variable "tags" {
  type        = map(string)
  description = "Any tags that should be present on the resources."
  default     = {}
}