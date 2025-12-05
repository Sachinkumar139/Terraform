variable "resource_group_info" {
  type = object({
    name     = string
    location = string
  })
  description = "resource group information"
  default = {
    location = "eastus"
    name     = "ntier"
  }
}
variable "network_info" {
  type = object({
    name          = string
    address_space = string
    subnets = list(object({
      name          = string
      address_space = string
    }))
  })
  default = {
    name          = "ntier"
    address_space = "192.168.0.0/16"
    subnets = [{
      name          = "web"
      address_space = "192.168.0.0/24"
      }, {
      name          = "app"
      address_space = "192.168.1.0/24"
      }, {
      name          = "db"
      address_space = "192.168.2.0/24"
    }]
  }
}

variable "web_security_group" {
  type = object({
    name = string
    rules = map(object({
      priority                   = number
      direction                  = string
      protocol                   = string
      source_port_range          = string
      destination_port_range     = string
      source_address_prefix      = string
      destination_address_prefix = string
      access                     = string
    }))
  })
  default = {
    name = "web"
    rules = {
      "webssh" = {
        priority                   = 300
        direction                  = "Inbound"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
        access                     = "Allow"
      },
      "webhttp" = {
        priority                   = 310
        direction                  = "Inbound"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "80"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
        access                     = "Allow"
      },
      "webhttps" = {
        priority                   = 320
        direction                  = "Inbound"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "443"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
        access                     = "Allow"
      }
    }
  }

}
