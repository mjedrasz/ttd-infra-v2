# Terragrunt is a thin wrapper for Terraform that provides extra tools for working with multiple Terraform modules,
# remote state, and locking: https://github.com/gruntwork-io/terragrunt

# Configure Terragrunt to automatically store tfstate files in an S3 bucket
remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config  = {
    encrypt        = true
    bucket         = "ttd-non-prod-terraform-state"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = "eu-central-1"
    dynamodb_table = "terraform-locks"
  }
}

# Configure root level variables that all resources can inherit
terraform {
  extra_arguments "custom_vars" {
    commands = get_terraform_commands_that_need_vars()
    optional_var_files = [
      "${get_parent_terragrunt_dir()}/account.tfvars",
      find_in_parent_folders("region.tfvars", "ignore"),
      find_in_parent_folders("env.tfvars", "ignore")
    ]
  }
}

generate "common_variables" {
  path = "common-vars.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
variable "aws_region" {
  description = "The AWS region to deploy to (e.g. us-east-1)"
}

variable "aws_env" {
  description = "The AWS environemtn to deploy to (e.g. dev)"
}

variable "default_tags" {
  type    = map
  default = {}
}

EOF
}

generate "versions" {
  path = "versions.tf"
  if_exists = "skip"
  contents = <<EOF
terraform {
  required_providers {
    aws = {}
    template = {}
  }
  required_version = ">= 0.13"
}

EOF
}

generate "provider" {
  path = "provider.tf"
  if_exists = "skip"
  contents = <<EOF
provider "template" {
}

provider "aws" {
  region  = var.aws_region
}
EOF
}