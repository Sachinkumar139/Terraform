resource "azurerm_virtual_network" "main" {
  name                = var.network_info.name
  address_space       = [var.network_info.address_space]
  location            = azurerm_resource_group.base.location
  resource_group_name = azurerm_resource_group.base.name
  tags = {
    Environment = "Dev"
  }

  depends_on = [azurerm_resource_group.base]
}
resource "azurerm_subnet" "subnets" {
  count                = length(var.network_info.subnets)
  name                 = var.network_info.subnets[count.index].name
  address_prefixes     = [var.network_info.subnets[count.index].address_space]
  resource_group_name  = azurerm_resource_group.base.name
  virtual_network_name = azurerm_virtual_network.main.name
  depends_on           = [azurerm_virtual_network.main]
}