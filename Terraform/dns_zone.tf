module "dns-zone" {
  source  = "Retoxx-dev/dns-zone/azurerm"
  version = "1.0.1"

  resource_group_name = azurerm_resource_group.this.name

  dns_zone_name = "dziedzic.me"

  a_records = [
    {
      name               = "@"
      ttl                = 300
      target_resource_id = one(module.kubernetes-cluster.effective_outbound_ips)
    },
    {
      name               = "*"
      ttl                = 300
      target_resource_id = one(module.kubernetes-cluster.effective_outbound_ips)
    }
  ]
}
