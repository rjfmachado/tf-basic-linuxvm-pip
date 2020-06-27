terraform {
  required_version = ">= 0.12"
  required_providers {
    azurerm = "~> 2.0"
  }
}

provider "azurerm" {
  features {
    virtual_machine {
      delete_os_disk_on_deletion = true
    }
  }
}
