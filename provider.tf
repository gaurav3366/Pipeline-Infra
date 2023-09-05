terraform {
  backend "azurerm" {
    resource_group_name  = "test-pipeline"
    storage_account_name = "terraformsg1"
    container_name       = "terraform-state"
    key                  = "terraform.tfstate"
  }
}
provider "azurerm" {
  features {
  }
}