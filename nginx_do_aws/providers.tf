terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
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

provider "aws" {
  profile = "default"
  region  = "us-east-1"
}
