resource "azurerm_virtual_desktop_scaling_plan" "scalingplan" {
  count               = var.create_scaling_plan ? 1 : 0
  name                = "${azurerm_virtual_desktop_host_pool.avd-pool.name}-scalingplan-weekdays"
  location            = azurerm_resource_group.avd.location
  resource_group_name = azurerm_resource_group.avd.name
  friendly_name       = "${azurerm_virtual_desktop_host_pool.avd-pool.name}-scalingplan-weekdays"
  description         = "${azurerm_virtual_desktop_host_pool.avd-pool.name} Scaling Plan weekdays"
  time_zone           = "Central Europe Standard Time"
  schedule {
    name                                 = "Weekdays"
    days_of_week                         = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"]
    ramp_up_start_time                   = "07:00"
    ramp_up_load_balancing_algorithm     = "BreadthFirst"
    ramp_up_minimum_hosts_percent        = 20
    ramp_up_capacity_threshold_percent   = 75
    peak_start_time                      = "09:00"
    peak_load_balancing_algorithm        = "BreadthFirst"
    ramp_down_start_time                 = "16:00"
    ramp_down_load_balancing_algorithm   = "DepthFirst"
    ramp_down_minimum_hosts_percent      = 10
    ramp_down_force_logoff_users         = false
    ramp_down_wait_time_minutes          = 45
    ramp_down_notification_message       = "Please log off in the next 45 minutes..."
    ramp_down_capacity_threshold_percent = 80
    ramp_down_stop_hosts_when            = "ZeroActiveSessions"
    off_peak_start_time                  = "17:00"
    off_peak_load_balancing_algorithm    = "DepthFirst"
  }
  host_pool {
    hostpool_id          = azurerm_virtual_desktop_host_pool.avd-pool.id
    scaling_plan_enabled = true
  }
  depends_on = [azurerm_role_assignment.avd-rbac-poweronoffcontributor]
}

# Desktop Virtualization Power On/off Contributor to Azure Virtual Desktop host pool for scaling plans
resource "azurerm_role_assignment" "avd-rbac-poweronoffcontributor" {
  count                = var.create_scaling_plan ? 1 : 0
  scope                = "/subscriptions/${ARM_SUBSCRIPTION_ID}"
  role_definition_name = "Desktop Virtualization Power On Off Contributor"
  principal_id         = data.azuread_service_principal.avd.object_id
}
