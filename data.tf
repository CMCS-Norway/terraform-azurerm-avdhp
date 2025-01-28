data "azuread_service_principal" "avd" {
  count        = var.create_scaling_plan ? 1 : 0
  display_name = var.avd_displayname
}

output "azuread_service_principal" {
  value = data.azuread_service_principal.avd[0].object_id
}

data "azurerm_private_dns_zone" "file" {
  count               = var.create_private_endpoint ? 1 : 0
  name                = var.avd_private_dns_zone
  resource_group_name = var.private_endpoint_resource_group
  provider            = azurerm.connectivity
}

data azurerm_subscription "current" {
  
}

data "azurerm_virtual_network" "avd" {
  count               = var.create_private_endpoint ? 1 : 0
  name                = var.avd_vnet
  resource_group_name = var.avd_subnet_rg
}

data "azurerm_subnet" "PrivateEndpointSubnet" {
  count                   = var.create_private_endpoint ? 1 : 0
  name                    = "PrivateEndpointSubnet"
  virtual_network_name    = data.azurerm_virtual_network.avd[0].name
  resource_group_name     = data.azurerm_virtual_network.avd[0].resource_group_name
}
