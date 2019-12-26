# ---------------------------------------------------------------------------------------------------------------------
# TERRAGRUNT CONFIGURATION
# This is the configuration for Terragrunt, a thin wrapper for Terraform that supports locking and enforces best
# practices: https://github.com/gruntwork-io/terragrunt
# ---------------------------------------------------------------------------------------------------------------------

# Terragrunt will copy the Terraform configurations specified by the source parameter, along with any files in the
# working directory, into a temporary folder, and execute your Terraform commands in that folder.
terraform {
  source = "git::git@github.com:mjedrasz/ttd_terraform.git//s3web?ref=v0.0.1"
}
# Include all settings from the root terraform.tfvars file
include {
  path = "${find_in_parent_folders()}"
}

# ---------------------------------------------------------------------------------------------------------------------
# MODULE PARAMETERS
# These are the variables we have to pass in to use the module specified in the terragrunt configuration above
# ---------------------------------------------------------------------------------------------------------------------

inputs = {
  bucket_name          = "organiser-ui-ttd-pl"
  cors_allowed_headers = ["*"]
  cors_allowed_methods = ["GET", "POST"]
  cors_allowed_origins = ["*"]
}