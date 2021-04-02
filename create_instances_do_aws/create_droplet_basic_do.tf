resource "digitalocean_droplet" "nginx_basic_web" {
  image     = "ubuntu-18-04-x64"
  name      = "droplet-do"
  region    = "nyc1"
  size      = "s-1vcpu-1gb"
  ssh_keys  = [digitalocean_ssh_key.daniel.fingerprint]
}
