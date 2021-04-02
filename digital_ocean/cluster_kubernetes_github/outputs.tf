resource "local_file" "kubernetes_config" {
  content = digitalocean_kubernetes_cluster.learning.kube_config.0.raw_config
  filename = "kubeconfig.yaml"
}

resource "github_actions_secret" "kubernetes_config" {
  repository       = "learning"
  secret_name      = "kubernetes_config"
  plaintext_value  = base64encode(digitalocean_kubernetes_cluster.learning.kube_config.0.raw_config)
}
