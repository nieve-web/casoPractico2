# ============================================
# 🔹 Configuración del Clúster Azure Kubernetes Service (AKS)
# ============================================

# --------------------------------------------
# 🔹 Creación del Clúster de Kubernetes en Azure (AKS)
# --------------------------------------------
resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.aks_name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.aks_dns_prefix 
  sku_tier            = "Standard"

  # Definimos el grupo de nodos
  default_node_pool {
    name       = "default"
    node_count = var.aks_node_count
    vm_size    = var.aks_vm_size
  }

  identity {
    type = "SystemAssigned"
  }

  role_based_access_control_enabled = true

  # 🔹 Configuración de red recomendada
  network_profile {
    network_plugin    = "azure"
    network_policy    = "azure"
    load_balancer_sku = "standard"
  }

  tags = {
    environment = "casopractico2"
  }

  # 🔹 Asegura que el RG se cree antes de AKS  
  depends_on = [azurerm_resource_group.rg]
}

