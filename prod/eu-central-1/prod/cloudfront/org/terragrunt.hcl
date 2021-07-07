# ---------------------------------------------------------------------------------------------------------------------
# TERRAGRUNT CONFIGURATION
# This is the configuration for Terragrunt, a thin wrapper for Terraform that supports locking and enforces best
# practices: https://github.com/gruntwork-io/terragrunt
# ---------------------------------------------------------------------------------------------------------------------

dependencies {
  paths = ["../../s3/org"]
}

# Terragrunt will copy the Terraform configurations specified by the source parameter, along with any files in the
# working directory, into a temporary folder, and execute your Terraform commands in that folder.
terraform {
  source = "git::ssh://git-codecommit.eu-central-1.amazonaws.com/v1/repos/ttd-terraform.git//cloudfront"
}

# Include all settings from the root terraform.tfvars file
include {
  path = find_in_parent_folders()
}

dependency "s3_bucket" {
  config_path = "${get_terragrunt_dir()}/../../s3/org"

  mock_outputs = {
    bucket_domain_name              = "org-ttd"
    cloudfront_access_identity_path = "org-aip"
  }
  mock_outputs_allowed_terraform_commands = ["validate", "plan"]
}

# ---------------------------------------------------------------------------------------------------------------------
# MODULE PARAMETERS
# These are the variables we have to pass in to use the module specified in the terragrunt configuration above
# ---------------------------------------------------------------------------------------------------------------------

inputs = {
  bucket_domain_name     = dependency.s3_bucket.outputs.bucket_domain_name
  origin_id              = dependency.s3_bucket.outputs.bucket_domain_name
  origin_access_identity = dependency.s3_bucket.outputs.cloudfront_access_identity_path
  target_origin_id       = dependency.s3_bucket.outputs.bucket_domain_name
  name                   = "org"
  aliases                = ["www.organiser.ttd.pl"]
}

