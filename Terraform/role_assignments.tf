module "role-assignments" {
  source  = "Retoxx-dev/role-assignment/azurerm"
  version = "1.0.1"

  role_assignments = [
    {
      scope = module.container-registry.id
      sp_names = [
        "sampleapp-core-githubactions",
        "sampleapp-messaging-githubactions",
        "sampleapp-client-githubactions",
        "sampleapp-infra-githubactions",
      ]
      role_names = ["AcrPush"]
    },
    {
      scope = module.container-registry.id
      principal_ids = [ 
        module.kubernetes-cluster.nodepool_identity_object_id
      ]
      role_names = ["AcrPull"]
    }
  ]
}