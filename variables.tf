###################################
#   Host pool specific variables  #
###################################

variable "rdp_properties" {
  type    = string
  default = "audiocapturemode:i:1;audiomode:i:0;redirectprinters:i:1;drivestoredirect:s:c\\:;autoreconnection enabled:i:1;enablerdsaadauth:i:1;use multimon:i:1;dynamic resolution:i:1;networkautodetect:i:1"
}

variable "maximum_sessions_allowed" {
  type        = number
  description = "Maximum hostpool sessions allowed on session hosts in host pool"
  default     = 10
}

variable "type" {
  type        = string
  description = "What hostpool type to use in the hostpool"
  default     = "Pooled"
}

variable "load_balancer_type" {
  type        = string
  description = "Acceptable values are: BreadthFirst, DepthFirst or Persistent"
  default     = "DepthFirst"
}

variable "security_enabled" {
  type        = string
  description = "Whether the group is a security group for controlling access to in-app resources. At least one of security_enabled or mail_enabled must be specified. A group can be security enabled and mail enabled"
  default     = true
}

variable "start_vm_on_connect" {
  type        = bool
  description = "Start the VM on connect if no available sessions"
  default     = true
}

variable "location" {
  type        = string
  description = "Where will the host pool be deployed"
  default     = "West Europe"
}

variable "root_name" {
  type        = string
  description = "Should be a unique identifier, short name for a customer, project or something"
  default     = "csn"
}

variable "subscription_id" {
  type        = string
  description = "Subscription ID where virtual machine sessions hosts are located, this should be it's own subscription ID in production environments"
  default     = null
}

variable "apps" {
  type        = map(string)
  description = "Name of apps that will be deployed in a key value pair for each app"
  default = {
    key = "value"
  }
}

variable "hostpool" {
  type        = string
  description = "Name of hostpool that will be deployed"
  default     = "prod-01"
}

variable "validate_environment" {
  type        = bool
  description = "Wether to validate environment or not"
  default     = false
}

variable "create_scaling_plan" {
  type        = bool
  description = "true or false if you want to create scaling plan and attach to the host pool"
  default     = false
}

variable "avd_displayname" {
  type        = string
  description = "Display name of Azure Virtual Desktop Enterprise application in Entra ID"
  default     = "Azure Virtual Desktop"
}
