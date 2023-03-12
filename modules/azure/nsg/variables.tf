# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED MODULE PARAMETERS
# ---------------------------------------------------------------------------------------------------------------------

variable "prefix" {
  type        = string
  description = "The prefix"
}

variable "location" {
  type        = string
  description = "The location"
}

variable "resource_group_name" {
  type        = string
  description = "The name of your Resource Group"
}

variable "label" {
  type        = string
  description = "The label"
}

# ---------------------------------------------------------------------------------------------------------------------
# OPTIONAL MODULE PARAMETERS
# ---------------------------------------------------------------------------------------------------------------------

variable "nsg_rules" {
  description = "Network security rules to add to all subnet."
  type        = list(object({
    name                                       = string,
    direction                                  = string
    access                                     = string
    protocol                                   = string
    description                                = string
    source_port_range                          = optional(string)
    source_port_ranges                         = optional(list(string))
    destination_port_range                     = optional(string)
    destination_port_ranges                    = optional(list(string))
    source_address_prefix                      = optional(string)
    source_address_prefixes                    = optional(list(string))
    source_application_security_group_ids      = optional(list(string))
    destination_address_prefix                 = optional(string)
    destination_address_prefixes               = optional(list(string))
    destination_application_security_group_ids = optional(list(string))
  }))
  default = []
}

variable "tags" {
  type        = map(string)
  description = "Any tags that should be present on the resources"
  default     = {}
}
