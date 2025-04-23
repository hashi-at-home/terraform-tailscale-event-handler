# variables.tf
# Use this file to declare the variables that the module will use.

# A dummy variable is provided to force a test validation
# variable "dummy" {
#   type        = string
#   description = "dummy variable"
# }

variable "domain_name" {
  type        = string
  description = "The domain name for the webhook"
}

variable "zone" {
  type        = string
  description = "The zone for the domain name"
}

variable "worker_name" {
  type = string
  default = "tailscale-event-receiver"
}

variable "devices" {
  type = map(list(string))
  description = "A map of devices and their tags"
  default = {
    "wallpi" = ["pizero"]
  }
}
