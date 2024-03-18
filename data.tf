data "azuread_service_principal" "avd" {
  display_name = var.avd_displayname
}

output "azuread_service_principal" {
  value = data.azuread_service_principal.avd.object_id
}

data "azurerm_subnet" "avd" {
  name = var.avd_subnet_name
  resource_group_name = "${var.root_name}-connectivity-${var.location}"
  virtual_network_name = "${var.root_name}${var.avd_vnet}"
}

data "azurerm_private_dns_zone" "file" {
  count               = var.create_private_endpoint ? 1 : 0
  name                = var.avd_private_dns_zone
  resource_group_name = "${var.root_name}-dns"
  provider            = azurerm.connectivity
}