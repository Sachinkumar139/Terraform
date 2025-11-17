variable "region" {
  type        = string
  description = "region for the current template"
  default     = "ap-south-1"
}

variable "network_info" {
  description = "this is vpc info"

  type = object({
    name = string
    cidr = string
    subnets = list(object({
      name = string
      cidr = string
      az   = string
    }))
  })

  default = {
    name = "nop"
    cidr = "10.0.0.0/16"

    subnets = [
      {
        name = "app1"
        az   = "ap-south-1a"
        cidr = "10.0.0.0/24"
      },
      {
        name = "app2"
        cidr = "10.0.1.0/24"
        az   = "ap-south-1b"
      },
      {
        name = "db-1"
        az   = "ap-south-1a"
        cidr = "10.0.2.0/24"
      },
      {
        name = "db-2"
        az   = "ap-south-1b"
        cidr = "10.0.3.0/24"
      }
    ]
  }
}
