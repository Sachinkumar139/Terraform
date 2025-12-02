variable "resource_group_info" {
    type = object({
      name = string
      location = string 
    })
    description = "resource group information"
    default = {
      location = "eastus"
      name = "ntier"
    }
  
}