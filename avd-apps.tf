############################
# AVD Application pool 01 apps
############################

# Creates application group and associates it to the host pool defined
resource "azurerm_virtual_desktop_application_group" "dag" {   
    for_each            = var.apps
    name                = "${each.key}-app-${azurerm_virtual_desktop_host_pool.avd-pool.name}-avd"
    friendly_name       = "${each.value} - ${azurerm_virtual_desktop_host_pool.avd-pool.name}"
    description         = "${each.value} Application on ${azurerm_virtual_desktop_host_pool.avd-pool.friendly_name}"
    resource_group_name = azurerm_virtual_desktop_host_pool.avd-pool.resource_group_name
    tags                = azurerm_virtual_desktop_host_pool.avd-pool.tags
    location            = azurerm_virtual_desktop_host_pool.avd-pool.location
    host_pool_id        = azurerm_virtual_desktop_host_pool.avd-pool.id
    type                = "RemoteApp"
}

resource "azurerm_virtual_desktop_workspace_application_group_association" "dag" {
    for_each                = var.apps
    workspace_id            = azurerm_virtual_desktop_workspace.avd-workspace.id
    application_group_id    = azurerm_virtual_desktop_application_group.dag[each.key].id
    depends_on = [
        azurerm_virtual_desktop_application_group.dag,
        azurerm_virtual_desktop_workspace.avd-workspace
    ]
}

############################
# AVD Applications role assignment as Desktop Virtualization User on the group created below
############################

resource "azurerm_role_assignment" "dag" {
    for_each             = var.apps
    scope                = azurerm_virtual_desktop_application_group.dag[each.key].id
    role_definition_name = "Desktop Virtualization User"
    principal_id         = azuread_group.dag[each.key].object_id
}

############################
# AVD Applications Entra ID group that will be associated to the DAG
############################

resource "azuread_group" "dag" {
  for_each         = var.apps
  display_name     = "G-AVD-APP-${each.key}"
  description      = "Grant users access to ${each.value} in AVD. (Source: Terraform)"
  security_enabled = true
}