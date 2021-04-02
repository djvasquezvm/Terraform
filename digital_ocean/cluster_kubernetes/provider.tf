terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "1.22.2"
    }
  }
}

variable "do_token" {} #defined in .bash_profile TF_VAR_do_token

provider "digitalocean" {
  token = var.do_token
}

