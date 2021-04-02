resource "digitalocean_kubernetes_cluster" "learning" {
  name    = "learning"
  region  = "nyc1"
  version = "1.18.8-do.0"
  tags    = ["staging"]

  node_pool {
    name       = "worker-pool"
    size       = "s-1vcpu-2gb"
    node_count = 1
    tags       = ["learning-nodes"]
  }
}
