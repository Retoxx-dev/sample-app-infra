module "virtual-network" {
  source  = "Retoxx-dev/virtual-network/azurerm"
  version = "1.0.2"

  resource_group_name = azurerm_resource_group.this.name
  location            = local.location

  name          = "vnet-${local.naming_convention_dash}"
  address_space = ["10.0.0.0/16"]

  subnets = [
    {
      name             = "snet-${local.naming_convention_dash}-aks"
      address_prefixes = ["10.0.240.0/21"]
    },
    {
      name             = "snet-${local.naming_convention_dash}-postgres"
      address_prefixes = ["10.0.255.224/27"]
      subnet_delegations = [
        {
          name         = "PostgreSQLDelegation"
          service_name = "Microsoft.DBforPostgreSQL/flexibleServers"
          service_actions = [
            "Microsoft.Network/virtualNetworks/subnets/join/action"
          ]
        }
      ]
    }
  ]
}

#Temp untill private dns zone module
resource "azurerm_private_dns_zone" "this" {
  name                = "privatelink.postgres.database.azure.com"
  resource_group_name = azurerm_resource_group.this.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "this" {
  name                  = "vdn-psql-${local.naming_convention_dash}"
  private_dns_zone_name = azurerm_private_dns_zone.this.name
  resource_group_name   = azurerm_resource_group.this.name
  virtual_network_id    = module.virtual-network.id
}