terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "1.22.2"
    }
    circleci = {
      source = "TomTucka/circleci"
      version = "0.2.0"
    }
  }
}

variable "do_token" {} #defined in .bash_profile TF_VAR_do_token
variable "circleci_token" {} #defined in .bash_profile TF_VAR_do_token

provider "digitalocean" {
  token = var.do_token
}

provider "circleci" {
  token    = var.circleci_token
  organization = "djvasquezvm"
}
