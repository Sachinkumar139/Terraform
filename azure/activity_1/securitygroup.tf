resource "azurerm_network_security_group" "web" {
    name = var.web_security_group.name
    location = azurerm_resource_group.base.location
    resource_group_name = azurerm_resource_group.base.name
    depends_on = [ azurerm_resource_group.base ]  
}

resource "azurerm_network_security_rule" "web" {
    count = length(var.web_security_group.rules)
    name = var.web_security_group.rules[count.index].name
    priority = var.web_security_group.rules[count.index].priority
    direction = var.web_security_group.rules[count.index].direction
    protocol = var.web_security_group.rules[count.index].protocol
    source_port_range = var.web_security_group.rules[count.index].source_port_range
    destination_port_range = var.web_security_group.rules[count.index].destination_port_range
    source_address_prefix = var.web_security_group.rules[count.index].source_address_prefix
    destination_address_prefix = var.web_security_group.rules[count.index].destination_address_prefix
    network_security_group_name = azurerm_network_security_group.web.name
    resource_group_name         = azurerm_resource_group.base.name
    access = var.web_security_group.rules[count.index].access
  
}