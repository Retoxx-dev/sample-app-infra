module "storage-account-logs" {
  source  = "Retoxx-dev/storage-account/azurerm"
  version = "1.0.0"

  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location

  name = "st${replace(local.naming_convention_dash, "-", "")}logs"
  
  blob_properties = {
    versioning_enabled = true
    change_feed_enabled = true
  }

  storage_containers =[
    {
      name = "loki"
    },
    {
      name = "admin"
    },
    {
      name = "chunks"
    },
    {
      name = "ruler"
    }
  ]
}