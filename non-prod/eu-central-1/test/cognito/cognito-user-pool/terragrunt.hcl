# ---------------------------------------------------------------------------------------------------------------------
# TERRAGRUNT CONFIGURATION
# This is the configuration for Terragrunt, a thin wrapper for Terraform that supports locking and enforces best
# practices: https://github.com/gruntwork-io/terragrunt
# ---------------------------------------------------------------------------------------------------------------------

# Terragrunt will copy the Terraform configurations specified by the source parameter, along with any files in the
# working directory, into a temporary folder, and execute your Terraform commands in that folder.
terraform {
  source = "git::git@github.com:mjedrasz/ttd_terraform.git//cognito/cognito-user-pool?ref=v0.0.1"
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
  user_pool_domain                = "ttd"
  user_pool_name                  = "ttd"
  reply_to_email_address          = "team@ttd.pl"
  user_verification_email_subject = "Your verification code"
  user_verification_email_message = "Hi,<br/><br/>Your verification code: {####}<br/><br/>Regards,<br/>Team"

  org_pool_domain            = "org-ttd"
  org_pool_name              = "org-ttd"
  org_reply_to_email_address = "team@ttd.pl"

}
