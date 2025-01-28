####################################
# AVD Storage Account for File Services (Pr“ofiles, Installers, etc)
####################################
resource "azurerm_storage_account" "avdstorage" {
  count                         = var.create_storage_account ? 1 : 0
  name                          = "st${var.root_name}avdpremium"
  resource_group_name           = azurerm_resource_group.avd.name
  location                      = var.location_storage_account
  tags                          = azurerm_resource_group.avd.tags
  account_tier                  = var.account_tier
  account_kind                  = var.account_kind
  account_replication_type      = var.account_replication_type
  min_tls_version               = var.min_tls_version
  public_network_access_enabled = var.public_network_access_enabled
  depends_on = [ azurerm_resource_group.avd ]
  azure_files_authentication {
    directory_type = var.directory_type
  }
}

# Create File Shares
resource "azurerm_storage_share" "profiles" {
  count                 = var.create_storage_account ? 1 : 0
  name                  = var.storage_share_name
  storage_account_id    = azurerm_storage_account.avdstorage[0].id
  quota                 = var.profiles_quota
  depends_on            = [azurerm_storage_account.avdstorage[0]]
}

# Private Endpoints for AVD Storage Account in AVD Subnet
resource "azurerm_private_endpoint" "avdstorage-file-endpoint" {
  count               = var.create_private_endpoint ? 1 : 0
  name                = "${azurerm_storage_account.avdstorage[0].name}-file-endpoint"
  resource_group_name = azurerm_resource_group.avd.name
  location            = var.location_storage_account
  tags                = azurerm_resource_group.avd.tags
  subnet_id           = data.azurerm_subnet.PrivateEndpointSubnet[0].id

  private_service_connection {
    name                           = "${azurerm_storage_account.avdstorage[0].name}-file-connection"
    private_connection_resource_id = azurerm_storage_account.avdstorage[0].id
    is_manual_connection           = false
    subresource_names = ["file"]
  }

  private_dns_zone_group {
      name                  = "default"
      private_dns_zone_ids  = [
        data.azurerm_private_dns_zone.file[0].id
        ]
    }

  depends_on = [
    azurerm_resource_group.avd,
    azurerm_storage_account.avdstorage[0],
    data.azurerm_subnet.avd
    ]
}

# RBAC: AVD Storage Account:
resource "azurerm_role_assignment" "smb_contributor" {
  count                 = var.create_storage_account ? 1 : 0
  scope                 = azurerm_storage_account.avdstorage[0].id
  role_definition_name  = "Storage File Data SMB Share Contributor"
  principal_id          = azuread_group.g-avd-users.object_id
  depends_on = [
    azurerm_storage_account.avdstorage[0],
    azuread_group.g-avd-users
    ]
}

resource "azurerm_role_assignment" "smb_elevated_contributor" {
  count                 = var.create_storage_account ? 1 : 0
  scope                 = azurerm_storage_account.avdstorage[0].id
  role_definition_name  = "Storage File Data SMB Share Elevated Contributor"
  principal_id          = azuread_group.g-avd-admins.object_id
  depends_on = [
    azurerm_storage_account.avdstorage[0],
    azuread_group.g-avd-admins
    ]
}