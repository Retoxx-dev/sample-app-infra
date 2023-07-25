module "role-assignments" {
  source  = "Retoxx-dev/role-assignment/azurerm"
  version = "1.0.1"

  role_assignments = [
    {
      scope = module.container-registry.id
      sp_names = [
        "sampleapp-core-githubactions",
        "sampleapp-messaging-githubactions",
        "sampleapp-client-githubactions"
      ]
      role_names = ["AcrPush"]
    }
  ]
}