# Main definition

data "vault_kv_secret_v2" "cloudflare" {
  mount = "cloudflare"
  name = "${var.zone}"
}
# The cloudflare worker will handle the events emitted by the tailscale webhook
# We will handle the worker with wrangler, it only needs to be updated by terraform when states change.

# The configuration file is templated, with our variables
resource "local_file" "wrangler" {
  content = templatefile("${path.module}/workers/tailscale-event-receiver/wrangler.jsonc.tmpl", {
    worker_name = "tailscale-event-receiver",
    domain_name = "${var.domain_name}",
    zone = "${var.zone}"
  })
  filename = "${path.module}/workers/tailscale-event-receiver/wrangler.jsonc"
  file_permission = 0644
}

# data "cloudflare_zone" "selected" {
#   filter = {
#     name = var.zone
#   }
# }

# Currently broken: https://github.com/cloudflare/terraform-provider-cloudflare/issues/5501
# resource "cloudflare_workers_route" "tailscale" {
#   pattern  = "https://${var.domain_name}.${var.zone}/webhook"
#   zone_id = data.cloudflare_zone.selected.zone_id
#   # script = "${var.worker_name}"
#   # route_id = "tailscale"
# }


# So, this is a null resource to provision the worker
resource "null_resource" "worker" {
  provisioner "local-exec" {
    command = "npx wrangler deploy"
    working_dir = "${path.module}/workers/tailscale-event-receiver"
    environment = {
      CLOUDFLARE_API_TOKEN = data.vault_kv_secret_v2.cloudflare.data.api_token
    }
  }
}

# The tailscale webhook will emit events to the cloudflare worker url
resource "tailscale_webhook" "receiver" {
  endpoint_url  = "https://${var.domain_name}.${var.zone}"
  subscriptions = [
    "categoryTailnetManagement",
    "nodeCreated",
    "nodeDeleted",
    "nodeApproved",
    "nodeKeyExpired",
    "nodeKeyExpiringInOneDay",
    "userApproved",
    "userCreated",
    "userDeleted",
    "userNeedsApproval",
    "userRestored",
    "userRoleUpdated",
    "userSuspended"
  ]
}

data "tailscale_devices" "hah" {
  name_prefix = ""
}
