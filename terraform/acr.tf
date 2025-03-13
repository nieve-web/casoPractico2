# ============================================
# 🔹 Configuración del Azure Container Registry (ACR)
# ============================================

# --------------------------------------------
# 🔹 Creación del Azure Container Registry (ACR)
# --------------------------------------------
resource "azurerm_container_registry" "acr" {
  name                     = var.acr_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  sku                      = "Basic"  # Opción económica para pruebas
  admin_enabled            = true  # Activamos el acceso de administrador para facilitar la autenticación en el ejercicio
}

# --------------------------------------------
# 🔹 Asignación de permisos "AcrPull" al AKS para acceder al ACR
# --------------------------------------------
resource "azurerm_role_assignment" "acr_pull_permission_aks" {
  principal_id         = azurerm_kubernetes_cluster.aks.identity[0].principal_id
  role_definition_name = "AcrPull"
  scope                = azurerm_container_registry.acr.id

  depends_on = [
    azurerm_kubernetes_cluster.aks,
    azurerm_container_registry.acr
  ]
}

# --------------------------------------------
# 🔹 Asignación de permisos "AcrPull" a la VM Linux para acceder al ACR
# --------------------------------------------
resource "azurerm_role_assignment" "acr_pull_permission_vm" {
  principal_id            = azurerm_linux_virtual_machine.vm.identity[0].principal_id
  role_definition_name    = "AcrPull"
  scope                   = azurerm_container_registry.acr.id

    depends_on = [
    azurerm_linux_virtual_machine.vm
  ]
}
