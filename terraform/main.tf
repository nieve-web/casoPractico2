# ========================================================
# 🔹 Configuración del proveedor y autenticación con Azure
# ========================================================

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }

  # Se asegura que solo se ejecute con una version de Terraform igual o superior 
  required_version = ">= 1.11.0" 
}

provider "azurerm" {
  features {}

  # Autenticación mediante CLI de Azure
  subscription_id = var.subscription_id
}

# ============================================
# 🔹 Creación del Grupo de Recursos en Azure
# ============================================
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location

  tags = {
    environment = "casopractico2"
  }
}
