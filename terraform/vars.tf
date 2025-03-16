# ============================================
# 🔹 Variables de configuración
# ============================================

# --------------------------------------------
# 🔹 Máquina Virtual (VM)
# --------------------------------------------
variable "vm_name" {
  description = "Nombre de la Máquina Virtual"
  type        = string
  default     = "nievecp2vm"
}

variable "vm_size" {
  description = "Tamaño de la Máquina Virtual"
  type        = string
  default     = "Standard_B1s"
}

# --------------------------------------------
# 🔹 Grupo de Recursos
# --------------------------------------------
variable "resource_group_name" {
  description = "Nombre del Grupo de Recursos"
  type        = string
  default     = "nievecp2_rg"
}

variable "location" {
  description = "Ubicación de los recursos en Azure"
  type        = string
  default     = "West Europe"
}

# --------------------------------------------
# 🔹 Red (Networking)
# --------------------------------------------
variable "vnet_name" {
  description = "Nombre de la Virtual Network"
  type        = string
  default     = "nievecp2_vnet"
}

variable "subnet_name" {
  description = "Nombre de la Subnet"
  type        = string
  default     = "nievecp2_subnet"
}

variable "nsg_name" {
  description = "Nombre del Security Group"
  type        = string
  default     = "nievecp2_nsg"
}

# --------------------------------------------
# 🔹 Azure Container Registry (ACR)
# --------------------------------------------
variable "acr_name" {
  description = "Nombre del Azure Container Registry"
  type        = string
  default     = "nievecp2acr"
}

# --------------------------------------------
# 🔹 Clúster AKS
# --------------------------------------------
variable "aks_name" {
  description = "Nombre del Clúster AKS"
  type        = string
  default     = "nievecp2_aks"
}

variable "aks_node_count" {
  description = "Número de nodos en el clúster de AKS"
  type        = number
  default     = 1  # Puedes aumentar el número si necesitas más nodos
}

variable "aks_vm_size" {
  description = "Tamaño de los nodos del AKS"
  type        = string
  default     = "Standard_B2ms"
}

variable "aks_dns_prefix" {
  description = "Prefijo DNS para el clúster AKS"
  type        = string
  default     = "nievecp2-aks-dns"
}

# --------------------------------------------
# 🔹 Identificadores de la cuenta de Azure
# --------------------------------------------

# ID único de la suscripción de Azure donde se desplegarán los recursos.
#    - Se puede obtener ejecutando el comando:
#      az account show --query "id" --output tsv
#    - Este valor debe ser proporcionado al ejecutar Terraform.
variable "subscription_id" {
  description = "ID de la suscripción de Azure"
  type        = string
  default     = "1de20760-46f0-4bcd-ac7b-80dde7d63ce5" 
}
