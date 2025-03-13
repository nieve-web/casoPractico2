# ============================================
# 🔹 Configuración de la Red en Azure
# ============================================

# --------------------------------------------
# 🔹 Creación de la Red Virtual (VNet)
# --------------------------------------------
resource "azurerm_virtual_network" "vnet" {
  name                = "nievecp2_vnet"
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = ["10.0.0.0/16"]

  depends_on = [ azurerm_resource_group.rg ]
}

# --------------------------------------------
# 🔹 Creación de la Subred dentro de la VNet
# --------------------------------------------
resource "azurerm_subnet" "subnet" {
  name                 = "nievecp2_subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

# --------------------------------------------
# 🔹 Creación del Security Group (NSG)
# --------------------------------------------
resource "azurerm_network_security_group" "nsg" {
  name                = "nievecp2_nsg"
  location            = var.location
  resource_group_name = var.resource_group_name

  depends_on = [ azurerm_resource_group.rg ]
}

# 🔹 Reglas de Seguridad (Security Rules)
# 🔹 Permitir acceso SSH (Puerto 22)
resource "azurerm_network_security_rule" "allow_ssh" {
  name                        = "allow_ssh"
  priority                    = 1001
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.nsg.name
}

# 🔹 Permitir acceso HTTP (Puerto 80)
resource "azurerm_network_security_rule" "allow_http" {
  name                        = "allow_http"
  priority                    = 1002
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "80"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.nsg.name
}
