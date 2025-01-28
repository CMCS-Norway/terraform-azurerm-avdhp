# Access Groups for AVD
resource "azuread_group" "g-avd-users" {
    display_name     = "G-AVD-${var.root_name}-${var.hostpool}-Users"
    description      = "Grant users general access to Azure Virtual Desktop Environment and Resources (Source: Terraform)"
    security_enabled = var.security_enabled
}

resource "azuread_group" "g-avd-admins" {
    display_name     = "G-AVD-${var.root_name}-${var.hostpool}-Administrator"
    description      = "Grant users administrator access to Azure Virtual Desktop Resources and Virtual Machine Hosts (Source: Terraform)"
    security_enabled = var.security_enabled
}