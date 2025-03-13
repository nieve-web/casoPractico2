# ============================================
# 🔹 Configuración de la Máquina Virtual (VM)
# ============================================

# --------------------------------------------
# 🔹 Creación de la IP Pública para la VM
# --------------------------------------------
resource "azurerm_public_ip" "vm_public_ip" {
  name                = "nievecp2_vm_public_ip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"

  depends_on = [azurerm_resource_group.rg]
}

# --------------------------------------------
# 🔹 Creación de la Interfaz de Red (NIC)
# --------------------------------------------
resource "azurerm_network_interface" "nic" {
  name                = "nievecp2_nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet.id  # Se usa la subred de network.tf
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.vm_public_ip.id
  }
}

# --------------------------------------------
# 🔹 Asociación de la NIC con el Security Group
# --------------------------------------------
resource "azurerm_network_interface_security_group_association" "nic_nsg" {
  network_interface_id      = azurerm_network_interface.nic.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

# --------------------------------------------
# 🔹 Creación de la Clave SSH para la VM
# --------------------------------------------
resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "ssh_private_key" {
  content  = tls_private_key.ssh_key.private_key_pem
  filename = "${path.module}/id_rsa"
}

# --------------------------------------------
# 🔹 Creación de la Máquina Virtual Linux
# --------------------------------------------
resource "azurerm_linux_virtual_machine" "vm" {
  name                = var.vm_name
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = "Standard_B1s"
  admin_username      = "azureuser"

  network_interface_ids = [
    azurerm_network_interface.nic.id,
  ]

  depends_on = [ azurerm_resource_group.rg ]

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

  identity {
    type = "SystemAssigned"
  }

  admin_ssh_key {
    username   = "azureuser"
    public_key = tls_private_key.ssh_key.public_key_openssh
  }

  tags = {
    environment = "casopractico2"
  }
}
