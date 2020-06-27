resource "azurerm_network_interface" "nic" {
  name                = "nic-${var.name}"
  location            = var.location
  resource_group_name = var.rg

  ip_configuration {
    name                          = "ipconfig-${var.name}"
    subnet_id                     = var.subnetid
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip.id
  }
}

resource "azurerm_public_ip" "pip" {
  name                = "pip-${var.name}"
  location            = var.location
  resource_group_name = var.rg
  allocation_method   = "Static"
  domain_name_label   = var.name
}

resource "azurerm_linux_virtual_machine" "vm" {
  name                = var.name
  resource_group_name = var.rg
  location            = var.location
  size                = var.size
  admin_username      = var.adminuser
  network_interface_ids = [
    azurerm_network_interface.nic.id,
  ]

  admin_ssh_key {
    username   = var.adminuser
    public_key = file("~/.ssh/id_rsa.pub")
  }

  disable_password_authentication = true

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}
