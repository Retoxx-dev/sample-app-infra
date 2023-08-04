module "postgresql-flexible-server" {
  source  = "Retoxx-dev/postgresql-flexible-server/azurerm"
  version = "1.0.1"

  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location

  random_config = {
    login_length          = 16
    login_min_lower       = 8
    pass_length           = 24
    pass_override_special = "!#$%&*()-_=+[]{}<>:?"
  }

  name                = "psql-${local.naming_convention_dash}"
  psql_version        = 14
  subnet_id           = module.virtual-network.subnet_ids["snet-${local.naming_convention_dash}-postgres"]
  private_dns_zone_id = azurerm_private_dns_zone.this.id
  sku_name            = "B_Standard_B1ms"
  storage_mb          = "32768"

  authentication = {
    active_directory_auth_enabled = true
  }

  aad_admin_users = ["kacper@retoxxdev.onmicrosoft.com"]
}