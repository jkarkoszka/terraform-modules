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
  default = [{
    access                     = "Allow"
    description                = "Allow 443 port traffic to 192.168.0.1"
    destination_address_prefix = "192.168.0.1"
    destination_port_range     = "443"
    direction                  = "Inbound"
    name                       = "TCP-443-Internet"
    priority                   = 501
    protocol                   = "Tcp"
    source_address_prefix      = "Internet"
    source_port_range          = "*"
  }]
}

variable "tags" {
  type        = map(string)
  description = "Any tags that should be present on the resources."
  default     = {
    tfTest = true
  }
}
