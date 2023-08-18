module "key-vault-secrets" {
  source  = "Retoxx-dev/keyvault-secrets/azurerm"
  version = "1.0.0"

  key_vault_id = module.key-vault.key_vault_id
  secrets = [
    #################################################################
    # INFRA AND TOOLS SECRETS
    #################################################################
    {
      name = "rabbitmq-password-dev"
    },
    {
      name = "retoxx-dev-sso-ca"
    },
    #################################################################
    # DEV SECRETS
    #################################################################
    {
      name = "sample-app-core-dev-env"
    },
    {
      name = "sample-app-messaging-dev-env"
    }
  ]
}