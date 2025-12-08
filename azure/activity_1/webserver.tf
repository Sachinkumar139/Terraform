# public ip address

resource "azurerm_public_ip" "web" {
  name = "${var.web_server.name}-ip"
  resource_group_name = azurerm_resource_group.base.name
  location = azurerm_resource_group.base.location
  sku_tier = "Regional"
  allocation_method = "Static"
}