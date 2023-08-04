resource "azurerm_resource_group" "this" {
  name     = "rg-${local.naming_convention_dash}"
  location = local.location

  tags = local.tags
}