terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "1.22.2"
    }
    github = {
      source = "hashicorp/github"
      version = "3.0.0"
    }
  }
}

variable "do_token" {} #defined in .bash_profile TF_VAR_do_token
variable "github_token" {} #defined in .bash_profile TF_VAR_do_token

provider "digitalocean" {
  token = var.do_token
}

provider "github" {
  token = var.github_token
  owner = "djvasquezvm"
}
