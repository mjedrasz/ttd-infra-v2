# ---------------------------------------------------------------------------------------------------------------------
# TERRAGRUNT CONFIGURATION
# This is the configuration for Terragrunt, a thin wrapper for Terraform that supports locking and enforces best
# practices: https://github.com/gruntwork-io/terragrunt
# ---------------------------------------------------------------------------------------------------------------------

dependencies {
  paths = ["../../cloudfront/user"]
}

# Terragrunt will copy the Terraform configurations specified by the source parameter, along with any files in the
# working directory, into a temporary folder, and execute your Terraform commands in that folder.
terraform {
  source = "git::ssh://git-codecommit.eu-central-1.amazonaws.com/v1/repos/ttd-terraform.git//route53"
}

# Include all settings from the root terraform.tfvars file
include {
  path = find_in_parent_folders()
}

dependency "cloudfront" {
  config_path = "${get_terragrunt_dir()}/../../cloudfront/user"

  mock_outputs = {
    distribution_domain_name    = "ttd-user-domain-name"
    distribution_hosted_zone_id = "ttd-zone-id"
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# MODULE PARAMETERS
# These are the variables we have to pass in to use the module specified in the terragrunt configuration above
# ---------------------------------------------------------------------------------------------------------------------

inputs = {
  name                        = "user"
  cname                       = "www.ttd.pl"
  distribution_domain_name    = dependency.cloudfront.outputs.distribution_domain_name
  distribution_hosted_zone_id = dependency.cloudfront.outputs.distribution_hosted_zone_id

}
