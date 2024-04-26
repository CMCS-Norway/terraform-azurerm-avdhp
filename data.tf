data "azuread_service_principal" "avd" {
  display_name = var.avd_displayname
}

output "azuread_service_principal" {
  value = data.azuread_service_principal.avd.object_id
}

data "azurerm_subnet" "avd" {
  name = var.avd_subnet_name
  resource_group_name = var.avd_subnet_rg
  virtual_network_name = var.avd_vnet
}

data "azurerm_private_dns_zone" "file" {
  count               = var.create_private_endpoint ? 1 : 0
  name                = var.avd_private_dns_zone
  resource_group_name = var.private_endpoint_resource_group
  provider            = azurerm.connectivity
}

data azurerm_subscription "current" {
  
}