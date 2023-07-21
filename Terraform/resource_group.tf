resource "azurerm_resource_group" "this" {
  name     = "rg-sample-app"
  location = "northeurope"

  tags = local.tags
}