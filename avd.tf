# AVD Shared resources RG
resource "azurerm_resource_group" "avd" {
  #for_each = var.hostpool
  name     = "rg-avd-${var.hostpool}-hostpool-shared"
  location = var.location
  tags = {
    landingzone = "AVD"
    source      = "terraform"
    pool        = var.hostpool
  }
}

# AVD Workspace
resource "azurerm_virtual_desktop_workspace" "avd-workspace" {
  #for_each            = var.hostpool
  name                = "${var.root_name}-${var.hostpool}-workspace"
  resource_group_name = azurerm_resource_group.avd.name
  tags                = azurerm_resource_group.avd.tags
  location            = var.location
  friendly_name       = var.root_name
  description         = "AVD ${var.hostpool} Workspace for ${var.root_name}"
  depends_on = [
    azurerm_resource_group.avd
  ]
}

# AVD Host Pool
resource "azurerm_virtual_desktop_host_pool" "avd-pool" {
  #for_each                 = var.hostpool 
  name                     = "avd-${var.hostpool}-hostpool"
  friendly_name            = "${var.root_name} ${var.hostpool} host pool"
  location                 = var.location
  resource_group_name      = azurerm_resource_group.avd.name
  tags                     = azurerm_resource_group.avd.tags
  validate_environment     = var.validate_environment
  start_vm_on_connect      = var.start_vm_on_connect
  custom_rdp_properties    = var.rdp_properties
  description              = "${var.root_name} AVD ${var.hostpool} host pool"
  type                     = var.type
  maximum_sessions_allowed = var.maximum_sessions_allowed
  load_balancer_type       = var.load_balancer_type

  scheduled_agent_updates {
    enabled = true
    schedule {
      day_of_week = "Saturday"
      hour_of_day = 2
    }
  }

  lifecycle {
    ignore_changes = [maximum_sessions_allowed, custom_rdp_properties, load_balancer_type]
  }
}

# AVD RBAC Roles

# Desktop Virtualization User Session Operator
resource "azurerm_role_assignment" "avd-rbac-usersessionoperator" {
  #for_each             = var.hostpool 
  scope                = azurerm_virtual_desktop_host_pool.avd-pool.id
  role_definition_name = "Desktop Virtualization User Session Operator"
  principal_id         = azuread_group.g-avd-admins.object_id
  depends_on = [
    azurerm_virtual_desktop_host_pool.avd-pool
  ]
}