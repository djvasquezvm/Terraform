resource "digitalocean_ssh_key" "daniel" {
  name       = "nginx_key"
  public_key = file("id_rsa.pub")
}
