###################################
#   Host pool specific variables  #
###################################

variable "rdp_properties" {
  type    = string
  default = "audiocapturemode:i:1;audiomode:i:0;redirectprinters:i:1;drivestoredirect:s:c\\:;autoreconnection enabled:i:1;use multimon:i:1;dynamic resolution:i:1;networkautodetect:i:1;enablecredsspsupport:i:0;videoplaybackmode:i:1;devicestoredirect:s:*;redirectclipboard:i:1;redirectcomports:i:1;redirectsmartcards:i:1;redirectwebauthn:i:1;usbdevicestoredirect:s:*;screen mode id:i:1;smart sizing:i:1;camerastoredirect:s:*"
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
  default     = "westeurope"
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
  default     = true
}

variable "create_storage_account" {
  type = bool
  description = "True or false if you want to create a storage account for AVD user profiles"
  default = true
}

variable "avd_displayname" {
  type        = string
  description = "Display name of Azure Virtual Desktop Enterprise application in Entra ID"
  default     = "Azure Virtual Desktop"
}

variable "directory_type" {
  type = string
  description = "Storage account authentication type"
  default = "AADDS"
}

variable "account_kind" {
  type = string
  description = "Storage account kind"
  default = "FileStorage"
}

variable "account_tier" {
  type = string
  description = "Storage account tier"
  default = "Premium"
}

variable "account_replication_type" {
  type = string
  description = "Storage account replication type"
  default = "LRS"
}

variable "min_tls_version" {
  type = string
  description = "Storage account minimum TLS Vversion, should be minimum TLS 1_2"
  default = "TLS1_2"
}

variable "friendly_name" {
  type = string
  description = "Friendly name of the AVD host pool"
}

variable "storage_share_name" {
  type = string
  description = "AVD Profile storage share name"
  default = "profiles"
}
variable "create_private_endpoint" {
  type = bool
  description = "True or false if AVD storage account private endpoint should be created"
  default = false
}

variable "profiles_quota" {
  type = number
  description = "AVD Profiles storage share quota"
  default = 500
}

variable "avd_subnet_name" {
  type = string
  description = "AVD subnet name for private endpoint"
  default = "avdSubnet"
}

variable "avd_subnet_rg" {
type = string
  description = "AVD subnet's reosurce group name for private endpoint"
  default = null
}

variable "avd_private_dns_zone" {
  type = string
  description = "AVD private dns zone name for storage account"
  default = "privatelink.file.core.windows.net"
}

variable "avd_vnet" {
  type = string
  description = "vnet name minus root_name"
  default = "-landingzone-avd-westeurope-vnet"
}

variable "subscription_id_connectivity" {
  type = string
  description = "subscription ID for azurerm_private_dns_zone file resource"
  default = null
}

variable "public_network_access_enabled" {
  type = bool
  description = "should public_network_access_enabled be true or false"
  default = true
}

variable "private_endpoint_resource_group" {
  type = string
  description = "Name of the private endpoints resource group"
  default = null
}

variable "avd_object_id" {
  type = string
  description = "Azure/Windows Virtual Desktop enterprise app object id"
  default = null
}

variable "preferred_app_group_type" {
  type = string
  description = "What type of Host pool Preferred app group type do you want"
  default = "RailApplications"
}

variable "location_storage_account" {
  type = string
  description = "What location will the storage account be deployed too"
  default = "West Europe"
}