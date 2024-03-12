# Access Groups for AVD
resource "azuread_group" "g-avd-users" {
    #for_each         = var.hostpool 
    display_name     = "G-AVD-${var.hostpool}-Users"
    description      = "Grant users general access to Azure Virtual Desktop Environment and Resources (Source: Terraform)"
    security_enabled = var.security_enabled
}

resource "azuread_group" "g-avd-admins" {
    #for_each         = var.hostpool
    display_name     = "G-AVD-${var.hostpool}-Administrator"
    description      = "Grant users administrator access to Azure Virtual Desktop Resources and Virtual Machine Hosts (Source: Terraform)"
    security_enabled = var.security_enabled
}