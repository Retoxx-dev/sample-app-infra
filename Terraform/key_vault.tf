module "key-vault" {
  source  = "Retoxx-dev/keyvault/azurerm"
  version = "1.0.0"

  name                = "kv-${local.naming_convention_dash}"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location

  sku_name = "standard"

  public_network_access_enabled = true

  access_policies = [
    {
      azure_ad_user_upns      = ["kacper@retoxxdev.onmicrosoft.com"]
      key_permissions         = ["Backup", "Create", "Decrypt", "Delete", "Encrypt", "Get", "Import", "List", "Purge", "Recover", "Restore", "Sign", "UnwrapKey", "Update", "Verify", "WrapKey", "Release", "Rotate", "GetRotationPolicy", "SetRotationPolicy"]
      secret_permissions      = ["Backup", "Delete", "Get", "List", "Purge", "Recover", "Restore", "Set"]
      certificate_permissions = ["Backup", "Create", "Delete", "DeleteIssuers", "Get", "GetIssuers", "Import", "List", "ListIssuers", "ManageContacts", "ManageIssuers", "Purge", "Recover", "Restore", "SetIssuers", "Update"]
      storage_permissions     = ["Backup", "Delete", "DeleteSAS", "Get", "GetSAS", "List", "ListSAS", "Purge", "Recover", "RegenerateKey", "Restore", "Set", "SetSAS", "Update"]
    },
    {
      azure_ad_service_principal_names = ["aks-sample-app-neu-agentpool"]
      secret_permissions               = ["Get", "List"]
    }
  ]

  self_service_principal_id = "945fbe56-103c-44d4-868d-0b40bff00eb0"

  network_acls = {
    bypass                     = "AzureServices"
    default_action             = "Deny"
    ip_rules                   = ["185.157.14.184"]
    virtual_network_subnet_ids = []
  }

  private_endpoint = {
    name                          = "pep-kv-${local.naming_convention_dash}"
    subnet_id                     = module.virtual-network.subnet_ids["snet-${local.naming_convention_dash}-aks"]
    custom_network_interface_name = "nic-kv-${local.naming_convention_dash}"

    private_dns_zone_id = azurerm_private_dns_zone.kv.id
  }
}