# ---------------------------------------------------------------------------------------------------------------------
# TERRAGRUNT CONFIGURATION
# This is the configuration for Terragrunt, a thin wrapper for Terraform that supports locking and enforces best
# practices: https://github.com/gruntwork-io/terragrunt
# ---------------------------------------------------------------------------------------------------------------------

# Terragrunt will copy the Terraform configurations specified by the source parameter, along with any files in the
# working directory, into a temporary folder, and execute your Terraform commands in that folder.
terraform {

  source = "git::ssh://git-codecommit.eu-central-1.amazonaws.com/v1/repos/ttd-terraform.git//cognito/cognito-identity-provider"

}

# Include all settings from the root terraform.tfvars file
include {
  path = find_in_parent_folders()
}

# locals {
#   common_vars = read_terragrunt_config(find_in_parent_folders("env.tfvars"))
# }
dependency "cognito_user_pool" {
  config_path = "${get_terragrunt_dir()}/../../../cognito-user-pool/user"
}
# ---------------------------------------------------------------------------------------------------------------------
# MODULE PARAMETERS
# These are the variables we have to pass in to use the module specified in the terragrunt configuration above
# ---------------------------------------------------------------------------------------------------------------------

inputs = {
  provider_name     = "Google"
  provider_type     = "Google"
  authorize_scopes  = "email openid"
  attribute_mapping = {
                        email    = "email"
                        username = "sub"
                      }
  user_pool_id = dependency.cognito_user_pool.outputs.user_pool_id
}