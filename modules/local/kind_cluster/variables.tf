# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED MODULE PARAMETERS
# ---------------------------------------------------------------------------------------------------------------------

variable "prefix" {
  type        = string
  description = "The prefix"
}

variable "label" {
  type        = string
  description = "The label"
}

# ---------------------------------------------------------------------------------------------------------------------
# OPTIONAL MODULE PARAMETERS
# ---------------------------------------------------------------------------------------------------------------------

variable "k8s_version" {
  type = string
  description = "Kubernetes version (tag of the kindest/node docker image)"
  default = "kindest/node:v1.24.7"
}
