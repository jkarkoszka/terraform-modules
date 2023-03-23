# ---------------------------------------------------------------------------------------------------------------------
# OPTIONAL MODULE PARAMETERS
# ---------------------------------------------------------------------------------------------------------------------

variable "prefix" {
  type        = string
  description = "The prefix"
  default     = "tftest"
}

variable "label" {
  type        = string
  description = "The label"
  default     = "abcdfg"
}

variable "k8s_version" {
  type        = string
  description = "Kubernetes version (tag of the kindest/node docker image)"
  default     = "kindest/node:v1.24.7"
}
