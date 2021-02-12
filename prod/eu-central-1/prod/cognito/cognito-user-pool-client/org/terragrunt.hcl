# ---------------------------------------------------------------------------------------------------------------------
# TERRAGRUNT CONFIGURATION
# This is the configuration for Terragrunt, a thin wrapper for Terraform that supports locking and enforces best
# practices: https://github.com/gruntwork-io/terragrunt
# ---------------------------------------------------------------------------------------------------------------------

dependencies {
  paths = ["../../../cloudfront/org", "../../cognito-user-pool/org"]
}

# dependencies {
#   paths = ["../../cloudfront", "../cognito-user-pool", "../cognito-identity-provider"]
# }
# Terragrunt will copy the Terraform configurations specified by the source parameter, along with any files in the
# working directory, into a temporary folder, and execute your Terraform commands in that folder.

terraform {
  source = "git::ssh://git-codecommit.eu-central-1.amazonaws.com/v1/repos/ttd-terraform.git//cognito/cognito-user-pool-client"
}

# Include all settings from the root terraform.tfvars file
include {
  path = find_in_parent_folders()
}

dependency "cloudfront" {
  config_path = "${get_terragrunt_dir()}/../../../cloudfront/org"
}

dependency "cognito_user_pool" {
  config_path = "${get_terragrunt_dir()}/../../cognito-user-pool/org"
}

# ---------------------------------------------------------------------------------------------------------------------
# MODULE PARAMETERS
# These are the variables we have to pass in to use the module specified in the terragrunt configuration above
# ---------------------------------------------------------------------------------------------------------------------

# if deployed with a domain (route53 = true), append the production url to *_callback_urls and *_logout_urls - the last entry is assumed to be used by clients
# if route53 is not set (route53 = false), cloudfront domain is used instead
inputs = {
  client_name              = "org"
  callback_urls            = ["https://www.organiser.ttd.pl"]
  logout_urls              = ["https://www.organiser.ttd.pl"]
  route53                  = true
  distribution_domain_name = dependency.cloudfront.outputs.distribution_domain_name
  user_pool_id             = dependency.cognito_user_pool.outputs.user_pool_id
}