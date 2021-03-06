# Configure the Microsoft Azure Provider
terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "~>2.64.0"
    }
  }
}

# Configure the azurerm provider
provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy = true
    }   
  }
}
