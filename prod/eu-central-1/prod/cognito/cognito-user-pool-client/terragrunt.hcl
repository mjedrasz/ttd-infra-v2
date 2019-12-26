# ---------------------------------------------------------------------------------------------------------------------
# TERRAGRUNT CONFIGURATION
# This is the configuration for Terragrunt, a thin wrapper for Terraform that supports locking and enforces best
# practices: https://github.com/gruntwork-io/terragrunt
# ---------------------------------------------------------------------------------------------------------------------



dependencies {
  paths = ["../cognito-user-pool", "../cognito-identity-provider"]
}
# Terragrunt will copy the Terraform configurations specified by the source parameter, along with any files in the
# working directory, into a temporary folder, and execute your Terraform commands in that folder.
terraform {
  source = "git::git@github.com:mjedrasz/ttd_terraform.git//cognito/cognito-user-pool-client?ref=v0.0.1"
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
  mobile_client_name          = "ttd-mobile-client"
  mobile_client_callback_urls = ["https://www.ttd.pl"]
  mobile_client_logout_urls   = ["https://www.ttd.pl"]

  web_client_name             = "ttd-web-client"
  web_client_callback_urls    = ["https://www.organiser.ttd.pl"]
  web_client_logout_urls      = ["https://www.organiser.ttd.pl"]

}