data "azuread_service_principal" "avd" {
  display_name = var.avd_displayname
}

output "azuread_service_principal" {
  value = data.azuread_service_principal.avd.object_id
}
