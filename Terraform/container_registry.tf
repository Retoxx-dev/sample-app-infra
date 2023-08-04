module "container-registry" {
  source  = "Retoxx-dev/container-registry/azurerm"
  version = "1.0.1"

  resource_group_name = azurerm_resource_group.this.name
  location            = local.location

  name = "acr${replace(local.naming_convention_dash, "-", "")}"
  sku  = "Standard"
}