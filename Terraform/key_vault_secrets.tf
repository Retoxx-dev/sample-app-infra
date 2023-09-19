module "key-vault-secrets" {
  source  = "Retoxx-dev/keyvault-secrets/azurerm"
  version = "1.0.0"

  key_vault_id = module.key-vault.key_vault_id
  secrets = [
    #################################################################
    # INFRA AND TOOLS SECRETS
    #################################################################
    {
      name = "retoxx-dev-sso-ca"
    },
    {
      name = "grafana-sso"
    },
    {
      name = "pgadmin-sso"
    },
    {
      name = "pgadmin-admin-password"
    },
    #################################################################
    # DEV SECRETS
    #################################################################
    {
      name = "rabbitmq-password-dev"
    },
    {
      name = "sample-app-core-dev-env"
    },
    {
      name = "sample-app-messaging-dev-env"
    },
    #################################################################
    # PROD SECRETS
    #################################################################
    {
      name = "rabbitmq-password-prod"
    },
    {
      name = "sample-app-core-prod-env"
    },
    {
      name = "sample-app-messaging-prod-env"
    }
  ]
}