# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED MODULE PARAMETERS
# ---------------------------------------------------------------------------------------------------------------------

variable "location" {
  type        = string
  description = "The location of the resources."
}

variable "prefix" {
  type        = string
  description = "The prefix used for the name of the resources."
}

variable "label" {
  type        = string
  description = "The label used for the name of the Resource Group eg. $/{prefix/}-$/{label/}-rg"
}

# ---------------------------------------------------------------------------------------------------------------------
# OPTIONAL MODULE PARAMETERS
# ---------------------------------------------------------------------------------------------------------------------

variable "tags" {
  type        = map(string)
  description = "Any tags that should be present on the resources"
  default     = {}
}