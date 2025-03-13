# ============================================
# 🔹 Outputs de la infraestructura desplegada
# ============================================

# Muestra el nombre del Grupo de Recursos creado
output "resource_group_name" {
  description = "Nombre del Grupo de Recursos creado en Azure"
  value       = azurerm_resource_group.rg.name
}

# Muestra la IP pública de la Máquina Virtual
output "vm_public_ip" {
  description = "Dirección IP pública de la Máquina Virtual"
  value       = azurerm_public_ip.vm_public_ip.ip_address
}

# Muestra el nombre del Azure Container Registry (ACR)
output "acr_name" {
  description = "Nombre del Azure Container Registry creado"
  value       = azurerm_container_registry.acr.name
}

# Muestra el nombre del Clúster AKS
output "aks_name" {
  description = "Nombre del Clúster de Kubernetes en Azure"
  value       = azurerm_kubernetes_cluster.aks.name
}

# Muestra el comando para acceder al AKS
output "aks_credentials_command" {
  description = "Comando para obtener credenciales de acceso al clúster AKS"
  value       = "az aks get-credentials --resource-group ${azurerm_kubernetes_cluster.aks.resource_group_name} --name ${azurerm_kubernetes_cluster.aks.name}"
}

# Muestra la URL del ACR para subir imágenes de contenedores
output "acr_login_server" {
  description = "URL del Azure Container Registry para hacer push de imágenes"
  value       = azurerm_container_registry.acr.login_server
}

# Muestra la contraseña de administrador del ACR (como información sensible)
output "acr_admin_password" {
  description = "Contraseña de administrador del ACR (oculta por seguridad)"
  value       = azurerm_container_registry.acr.admin_password
  sensitive   = true  # Esta línea oculta la contraseña en la salida por seguridad
}
