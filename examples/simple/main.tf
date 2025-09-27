# This is the default example
# customise it as you see fit for your example usage of your module

# add provider configurations here, for example:
# provider "aws" {
#
# }

# Declare your backends and other terraform configuration here
# This is an example for using the consul backend.
terraform {
  backend "consul" {
    path = "terraform/modules/terraform-tailscale-event-handler/simple"
  }

  required_providers {
    tailscale = {
      source  = "tailscale/tailscale"
      version = "~> 0.19"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 5.0"
    }
  }
}

# We will use vault in our invocatio of this module to retrieve secrets for our provider configuraitons
provider "vault" {}

data "vault_kv_secret_v2" "tailscale" {
  mount = "hashiatho.me-v2"
  name  = "tailscale"
}

data "vault_kv_secret_v2" "cloudflare" {
  mount = "cloudflare"
  name  = "brusisceddu.xyz"
}

provider "tailscale" {
  # Add your provider configuration here.
  api_key = data.vault_kv_secret_v2.tailscale.data.tailscale_api_token
  tailnet = data.vault_kv_secret_v2.tailscale.data.tailnet
}

provider "cloudflare" {
  api_token = data.vault_kv_secret_v2.cloudflare.data.api_token
}

// provider "cloudflare" {}
locals {
  zone        = "brusisceddu.xyz"
  domain_name = "tailscale"
  worker_name = "tailscale-event-receiver"
}

module "example" {
  source      = "../../"
  worker_name = local.worker_name
  zone        = local.zone
  domain_name = local.domain_name
}
