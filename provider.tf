terraform {
  backend "azurerm" {
    resource_group_name  = "test-pipeline"
    storage_account_name = "terraformsg1"
    container_name       = "terraform-state"
    key                  = "terraform.tfstate"
  }
}
provider "azurerm" {
  skip_provider_registration = "true"
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}
terraform {
  required_providers {
    cloudflare = {
      source = "cloudflare/cloudflare"
      //version = "~> 4.0"
    }
  }
}

provider "cloudflare" {
  //email = "gaurav.rai@ve3.global"
  api_token = var.cloudflare_api_token
}
