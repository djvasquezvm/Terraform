resource "digitalocean_kubernetes_cluster" "learning" {
  name    = "learning"
  region  = "nyc1"
  version = "1.18.8-do.1"
  tags    = ["staging"]

  node_pool {
    name       = "worker-pool"
    size       = "s-2vcpu-4gb"
    node_count = 2
    tags       = ["learning-nodes"]
  }
}
