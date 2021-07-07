# ---------------------------------------------------------------------------------------------------------------------
# TERRAGRUNT CONFIGURATION
# This is the configuration for Terragrunt, a thin wrapper for Terraform that supports locking and enforces best
# practices: https://github.com/gruntwork-io/terragrunt
# ---------------------------------------------------------------------------------------------------------------------

dependencies {
  paths = ["../../cognito-user-pool/user", "../../cognito-user-pool-client/user"]
}

# Terragrunt will copy the Terraform configurations specified by the source parameter, along with any files in the
# working directory, into a temporary folder, and execute your Terraform commands in that folder.
terraform {
  source = "git::ssh://git-codecommit.eu-central-1.amazonaws.com/v1/repos/ttd-terraform.git//cognito/cognito-identity-pool"
}

# Include all settings from the root terraform.tfvars file
include {
  path = find_in_parent_folders()
}


dependency "cognito_user_pool" {
  config_path = "${get_terragrunt_dir()}/../../cognito-user-pool/user"
  mock_outputs = {
    user_pool_id              = "user_user_pool_id"
  }
  mock_outputs_allowed_terraform_commands = ["validate", "plan"]
}


dependency "cognito_user_pool_client" {
  config_path = "${get_terragrunt_dir()}/../../cognito-user-pool-client/user"
  mock_outputs = {
    user_pool_client_id              = "user_pool_client_id"
  }
  mock_outputs_allowed_terraform_commands = ["validate", "plan"]
}


# ---------------------------------------------------------------------------------------------------------------------
# MODULE PARAMETERS
# These are the variables we have to pass in to use the module specified in the terragrunt configuration above
# ---------------------------------------------------------------------------------------------------------------------

inputs = {
  name                = "user"
  user_pool_client_id = dependency.cognito_user_pool_client.outputs.user_pool_client_id
  user_pool_id        = dependency.cognito_user_pool.outputs.user_pool_id
}
