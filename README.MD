# Things Todo infrastructure

Terragrunt for [ttd-terraform](https://github.com/mjedrasz/ttd-terraform)

## Getting Started

The project uses [Terragrunt](https://github.com/gruntwork-io/terragrunt) to manage shared resources across multiple deployment environments.

### Prerequisites

[Terragrunt](https://github.com/gruntwork-io/terragrunt) and [Terraform](https://www.terraform.io/) are required.

Before running terragrunt commands, few parameters needs to be defined manually in AWS Parameter Store, namely

* Identity providers ids and secrets (you need to setup OAuth2 clients in Facebook and Google developer consoles)
  * /{stage}/cognito/identity-provider/facebook/client-id
  * /{stage}/cognito/identity-provider/google/client-secret
  * /{stage}/cognito/identity-provider/facebook/client-id
  * /{stage}/cognito/identity-provider/google/client-secret

* Google APIs key (you need to create credentials allowing working with Places API in Google developer console)
  * /{stage}/google/api/key

substitute {stage} with the environment name, e.g. test.

## Installing

You can install the whole infrastructure for a given environment in one go executing, e.g.

```bash
cd non-prod/eu-central/test
terragrunt apply-all
```

To deploy a single module, navigate to that module and run

```bash
terragrunt apply
```

for instance, to setup elasticsearch module in a test environment

```bash
cd non-prod/eu-central/test/elasticsearch
terragrunt apply
```

## Without custom domain

If you don't have a domain and/or you don't want to buy/setup one via Route53 service, you can exclude modules which relies on a domain name

```bash
terragrunt apply-all --terragrunt-exclude-dir "route53/*" --terragrunt-exclude-dir ses
```

Withou a domain you access your static resources via Cloudfront-generated domain.

## Dry-run

To check which resources will be created or changed run

```bash
cd non-prod/eu-central/test
terragrunt plan-all
```

or individually, on module basis

```bash
cd non-prod/eu-central/test/elasticsearch
terragrunt plan
```

## Destroying

To destroy environment globally run

```bash
cd non-prod/eu-central/test
terragrunt destroy-all
```

or individually, on module basis

```bash
cd non-prod/eu-central/test/elasticsearch
terragrunt destroy
```

## License

This project is licensed under the MIT License - see the [LICENSE.MD](LICENSE.MD) file for details
