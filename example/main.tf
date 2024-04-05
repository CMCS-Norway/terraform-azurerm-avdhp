module "avdhp" {
  source           = "app.terraform.io/cmcs/avdhp/azurerm"
  version          = "1.1.0"
  default_location = "westeurope"                         #What region the AVD host pool and other resources will be deployed to, allowed regions are found here: https://learn.microsoft.com/en-us/azure/virtual-desktop/prerequisites?tabs=portal#azure-regions
  root_name        = "csn"                                #Should be a customer short name, or other unique identifier for a project or something similar, small letters, number and hypens.
  apps = {                                                #Each key value pair will be a application group deployed with their own "G-AVD-APP-KEY" name, that also will be given permissions to log onto AVD as a member, 
    "ssms"   = "SQL Server Management Studio"             #the app will then after it has been configured be visible as a remote application
    "vscode" = "Visual Studio Code"
  }
  hostpool                = "prod-01"                         #small letters, hypens and numbers, should be environment and number, prod-01, test-01, dev-03 or something similar
  create_scaling_plan     = false                             # Defaults to true, do you want to deploy and attach a AVD Scaling plan? Make sure avd_displayname is correct, if this fails, you most likely have to change it from "Azure Virtual Desktop" to "Windows Virtual Desktop"
  create_storage_account  = false                             # Defaults to true, do you want to create a private endpoint connection for the AVD profiles storage account
  create_private_endpoint = false                             # Defaults to true, do you want to create a private endpoint connection for the AVD profiles storage account
}
