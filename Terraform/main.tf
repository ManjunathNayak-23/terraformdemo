terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
    backend "azurerm" {} 
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
   skip_provider_registration = true
  features {}
}

# resource "azurerm_resource_group" "example" {
#   name     = "hms-demo"
#   location = "East US"
# }

resource "azurerm_network_security_group" "example" {
  name                = "example-security-group"
  location            = "East US"
  resource_group_name = "hms-demo"
}

resource "azurerm_virtual_network" "example" {
  name                = "example-network"
  location            ="East US"
  resource_group_name = "hms-demo"
  address_space       = ["10.0.0.0/16"]
  dns_servers         = ["10.0.0.4", "10.0.0.5"]

  subnet {
    name           = "subnet1"
    address_prefix = "10.0.1.0/24"
  }

  subnet {
    name           = "subnet2"
    address_prefix = "10.0.2.0/24"
    security_group = azurerm_network_security_group.example.id
  }

  tags = {
    environment = "Production"
  }
}
