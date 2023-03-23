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

variable "tags" {
  type        = map(string)
  description = "Any tags that should be present on the resources."
  default     = {
    tfTest = true
  }
}
