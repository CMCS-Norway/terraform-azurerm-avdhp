terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.42.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = ">=2.33.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "rg-mgmt-shared"
    storage_account_name = "tfstates"
    container_name       = "tfstate"   
    key                  = "avd-hp.tfstate"
  }
}
