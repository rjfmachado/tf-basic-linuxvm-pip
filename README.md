# Basic Linux VM with Public ip

Linux VM with:

- Ubuntu 18.04
- SSH Authentication only
- Public ip
- Standard B1s SKU
- Automatic Updates (reboot 02:00)
- Microsoft signing key
- Azure CLI APT Repository
- Azure CLI
- Customizable cloud-init
- Zone support

> Note: You are required to configure access to this virtual machine with an explicit NSG rule allowing SSH.

## Usage

```terraform

module "vm" {
  source       = "github.com/rjfmachado/tf-basic-linuxvm-pip"
  name         = "vm"
  rg           = azurerm_resource_group.hub.name
  subnetid     = azurerm_subnet.hub.id
  size         = "Standard_B2s"
}

resource "azurerm_network_security_group" "vm" {
  name                = "vm"
  location            = azurerm_resource_group.hub.location
  resource_group_name = azurerm_resource_group.hub.name
}

resource "azurerm_subnet_network_security_group_association" "vm" {
  subnet_id                 = azurerm_subnet.hub.id
  network_security_group_id = azurerm_network_security_group.vm.id
}

resource "azurerm_network_security_rule" "allowssh" {
  name                        = "allowssh"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "Internet"
  destination_address_prefix  = module.vm.privateip
  resource_group_name         = azurerm_resource_group.hub.name
  network_security_group_name = azurerm_network_security_group.vm.name
}
```
