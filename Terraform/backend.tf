terraform {
  backend "azurerm" {
    resource_group_name  = "rg-sample-infrastructure"
    storage_account_name = "stsampleterraform"
    container_name       = "terraform"
    key                  = "terraform.tfstate"
  }
}