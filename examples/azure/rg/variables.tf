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
  description = "The label used for the name of the Resource Group eg. $/{prefix/}-$/{label/}-rg"
  default     = "abcdfg"
}

variable "tags" {
  type        = map(string)
  description = "Any tags that should be present on the resources"
  default     = {
    tfTest = true
  }
}
