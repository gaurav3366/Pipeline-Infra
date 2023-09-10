# AKS Cluster DNS record
/* resource "cloudflare_record" "aks_cluster" {
  //zone_id = "your-cloudflare-zone-id"
  name  = azurerm_kubernetes_cluster.aks.name
  value = "your-aks-cluster-ip"
  type  = "A"
  ttl   = 300
} */

/* # VMSS DNS record
resource "cloudflare_record" "vmss" {
  //zone_id = "your-cloudflare-zone-id"
  name    = azurerm_linux_virtual_machine_scale_set.name
  value   = azurerm_linux_virtual_machine_scale_set.ip.id
  type    = "A"
  ttl     = 300
} */

/* # DDoS protection configuration
resource "cloudflare_zone_settings_override" "ddos" {
  //zone_id = "your-cloudflare-zone-id"
  settings {
    security_level           = "high"
    enable_under_attack_mode = true
  }
} */

/* # SSL offloading configuration
resource "cloudflare_zone_settings_override" "ssl" {
  //zone_id = "your-cloudflare-zone-id"
  settings {
    ssl = "flexible"
  }
} */

# Page caching configuration
/* resource "cloudflare_zone_settings_override" "caching" {
  //zone_id = "your-cloudflare-zone-id"
  settings {
    cache_level = "aggressive"
  }
} */
