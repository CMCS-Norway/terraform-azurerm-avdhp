module "avd" {
  source           = "../../modules/terraform_cmcs-avd"
  default_location = "West Europe"                        #What region the AVD host pool and other resources will be deployed to, allowed regions are found here: https://learn.microsoft.com/en-us/azure/virtual-desktop/prerequisites?tabs=portal#azure-regions
  subscription_id  = "XXXXXX-XXXXXX-XXXXXX-XXXXXX-XXXXXX" #Required to set permissions correct, should be same subscription ID as AVD resources are deployed too
  root_name        = "kan"                                #Should be a customer short name, or other unique identifier for a project or something similar, small letters, number and hypens.
  apps = {                                                #Each key value pair will be a application group deployed with their own "G-AVD-APP-KEY" name, that also will be given permissions to log onto AVD as a member, 
    "ssms"   = "SQL Server Management Studio"             #the app will then after it has been configured be visible as a remote application
    "vscode" = "Visual Studio Code"
  }
  hostpool            = "prod-01" #small letters, hypens and numbers, should be environment and number, prod-01, test-01, dev-03 or something similar
  create_scaling_plan = false     # Do you want to deploy and attach a AVD Scaling plan? Make sure avd_displayname is correct, if this fails, you most likely have to change it from "Azure Virtual Desktop" to "Windows Virtual Desktop"
}
