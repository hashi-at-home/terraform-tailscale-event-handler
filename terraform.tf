# Use this file to declare the terraform configuration
# Add things like:
# - required version
# - required providers
# Do not add things like:
# - provider configuration
# - backend configuration
# These will be declared in the terraform document which consumes the module.

terraform {
  required_version = ">1.9.0"
  required_providers {
    tailscale = {
      source = "tailscale/tailscale"
      version = "0.21.0"
    }

    cloudflare = {
      source = "cloudflare/cloudflare"
      version = "~> 5"
    }
    local = {
        source = "hashicorp/local"
        version = "~> 2"
    }
    null = {
      source = "hashicorp/null"
      version = "~> 3.2.1"
    }
  }
}
