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

variable "resource_group_name" {
  type        = string
  description = "The name of your Resource Group."
}

variable "label" {
  type        = string
  description = "The label."
}

variable "default_node_pool" {
  type = object({
    name                 = string
    vnet_subnet_id       = string
    min_count            = optional(number)
    node_count           = optional(number)
    max_count            = optional(number)
    vm_size              = optional(string)
    type                 = optional(string)
    enable_auto_scaling  = optional(bool)
    zones                = optional(list(string))
    orchestrator_version = optional(string)
    max_surge_on_upgrade = optional(string)
  })
  description = "The properties of the default node pool."
}

variable service_principal {
  type = object({
    client_id     = string
    client_secret = string
  })
  description = "The service principal for the cluster."
}

# ---------------------------------------------------------------------------------------------------------------------
# OPTIONAL MODULE PARAMETERS
# ---------------------------------------------------------------------------------------------------------------------

variable "kubernetes_version" {
  type        = string
  description = "Version of Kubernetes specified when creating the AKS managed cluster. If not specified, the latest recommended version will be used at provisioning time (but won't auto-upgrade)."
  default     = "1.24.9"
}

variable "network_plugin" {
  type        = string
  description = "Network plugin to use for networking. Currently supported values are azure, kubenet and none. Changing this forces a new resource to be created."
  default     = "kubenet"
}

variable "outbound_type" {
  type        = string
  description = "The outbound (egress) routing method which should be used for this Kubernetes Cluster. Possible values are loadBalancer, userDefinedRouting, managedNATGateway and userAssignedNATGateway. Defaults to loadBalancer. Changing this forces a new resource to be created."
  default     = "loadBalancer"
}

variable "load_balancer_sku" {
  type        = string
  description = "Specifies the SKU of the Load Balancer used for this Kubernetes Cluster. Possible values are basic and standard. Defaults to standard. Changing this forces a new resource to be created."
  default     = "standard"
}

variable "docker_bridge_cidr" {
  type        = string
  description = "IP address (in CIDR notation) used as the Docker bridge IP address on nodes. Changing this forces a new resource to be created."
  default     = "172.17.0.1/16"
}

variable "pod_cidr" {
  type        = string
  description = "The CIDR to use for pod IP addresses. This field can only be set when network_plugin is set to kubenet. Changing this forces a new resource to be created."
  default     = "10.244.0.0/16"
}

variable "service_cidr" {
  type        = string
  description = "The Network Range used by the Kubernetes service. Changing this forces a new resource to be created."
  default     = "10.0.0.0/16"
}

variable "dns_service_ip" {
  type        = string
  description = "IP address within the Kubernetes service address range that will be used by cluster service discovery (kube-dns). Changing this forces a new resource to be created."
  default     = "10.0.0.10"
}

variable "user_node_pools" {
  type = list(object({
    name                 = string
    vnet_subnet_id       = string
    min_count            = optional(number)
    node_count           = optional(number)
    max_count            = optional(number)
    vm_size              = optional(string)
    type                 = optional(string)
    enable_auto_scaling  = optional(bool)
    zones                = optional(list(string))
    orchestrator_version = optional(string)
    max_surge_on_upgrade = optional(string)
  }))
  description = "The list of object with properties of additional user node pools."
  default     = []
}

variable "tags" {
  type        = map(string)
  description = "Any tags that should be present on the resources."
  default     = {}
}
