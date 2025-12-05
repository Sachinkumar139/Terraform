resource "azurerm_network_security_group" "web" {
  name                = var.web_security_group.name
  location            = azurerm_resource_group.base.location
  resource_group_name = azurerm_resource_group.base.name
  depends_on          = [azurerm_resource_group.base]
}

resource "azurerm_network_security_rule" "web" {
  for_each                    = (var.web_security_group.rules)
  name                        = each.key
  priority                    = each.value.priority
  direction                   = each.value.direction
  protocol                    = each.value.protocol
  source_port_range           = each.value.source_port_range
  destination_port_range      = each.value.destination_port_range
  source_address_prefix       = each.value.source_address_prefix
  destination_address_prefix  = each.value.destination_address_prefix
  network_security_group_name = azurerm_network_security_group.web.name
  resource_group_name         = azurerm_resource_group.base.name
  access                      = each.value.access
  depends_on                  = [azurerm_network_security_group.web]

}