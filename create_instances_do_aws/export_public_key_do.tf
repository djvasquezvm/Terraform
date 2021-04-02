resource "digitalocean_ssh_key" "daniel" {
  name       = "danielkey"
  public_key = file("id_rsa.pub")
}
