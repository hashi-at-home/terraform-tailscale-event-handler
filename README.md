[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white)](https://github.com/pre-commit/pre-commit) [![pre-commit.ci status](https://results.pre-commit.ci/badge/github/brucellino/tfmod-template/main.svg)](https://results.pre-commit.ci/latest/github/brucellino/tfmod-template/main) [![semantic-release: conventional](https://img.shields.io/badge/semantic--release-conventional-e10079?logo=semantic-release)](https://github.com/semantic-release/semantic-release)

# tfmod-template

<!-- Delete this section when using the template repository -->

This is the template repository for my terraform modules.
It attempts to follow the [default structure](https://www.terraform.io/language/modules/develop/structure) for terraform modules.

It is designed to speed up development of new terraform modules by providing:

1. basic terraform setup for backend, providers, _etc_.
  1. the default required version for terraform is `>1.2.0`
1. common pre-commit hooks configuration
1. semantic release configuration
1. examples directory for testing and demonstration
1. default github actions workflows for testing and releasing

## How to use

<!-- Delete this section when using the template repository -->

If you want to make a new terraform module from scratch:

1. create a new repository using this one as template
1. delete the sections commented with `<!-- Delete this section when using the template repository -->`
1. update `terraform.tf` to declare the module's required providers
1. add the examples you need in `examples/<your example>`
1. update the test workflow in `.github/workflows/test.yml` to reflect your examples

## Pre-commit hooks

<!-- Edit this section or delete if you make no change  -->

The [pre-commit](https://pre-commit.com) framework is used to manage pre-commit hooks for this repository.
A few well-known hooks are provided to cover correctness, security and safety in terraform.

## Examples

The `examples/` directory contains the example usage of this module.
These examples show how to use the module in your project, and are also use for testing in CI/CD.

<!--

Modify this section according to the kinds of examples you want
You may want to change the names of the examples or the kinds of
examples themselves

-->

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.9.0 |
| <a name="requirement_cloudflare"></a> [cloudflare](#requirement\_cloudflare) | ~> 5 |
| <a name="requirement_local"></a> [local](#requirement\_local) | ~> 2 |
| <a name="requirement_null"></a> [null](#requirement\_null) | ~> 3.2.1 |
| <a name="requirement_tailscale"></a> [tailscale](#requirement\_tailscale) | 0.22.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_local"></a> [local](#provider\_local) | ~> 2 |
| <a name="provider_null"></a> [null](#provider\_null) | ~> 3.2.1 |
| <a name="provider_tailscale"></a> [tailscale](#provider\_tailscale) | 0.22.0 |
| <a name="provider_vault"></a> [vault](#provider\_vault) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [local_file.wrangler](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [null_resource.worker](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [tailscale_webhook.receiver](https://registry.terraform.io/providers/tailscale/tailscale/0.22.0/docs/resources/webhook) | resource |
| [tailscale_devices.hah](https://registry.terraform.io/providers/tailscale/tailscale/0.22.0/docs/data-sources/devices) | data source |
| [vault_kv_secret_v2.cloudflare](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/data-sources/kv_secret_v2) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_devices"></a> [devices](#input\_devices) | A map of devices and their tags | `map(list(string))` | <pre>{<br/>  "wallpi": [<br/>    "pizero"<br/>  ]<br/>}</pre> | no |
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | The domain name for the webhook | `string` | n/a | yes |
| <a name="input_worker_name"></a> [worker\_name](#input\_worker\_name) | n/a | `string` | `"tailscale-event-receiver"` | no |
| <a name="input_zone"></a> [zone](#input\_zone) | The zone for the domain name | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
