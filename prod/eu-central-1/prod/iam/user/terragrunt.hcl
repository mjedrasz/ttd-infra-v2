# ---------------------------------------------------------------------------------------------------------------------
# TERRAGRUNT CONFIGURATION
# This is the configuration for Terragrunt, a thin wrapper for Terraform that supports locking and enforces best
# practices: https://github.com/gruntwork-io/terragrunt
# ---------------------------------------------------------------------------------------------------------------------

dependencies {
  paths = ["../../cognito/cognito-identity-pool/user", "../../pinpoint"]
}

# Terragrunt will copy the Terraform configurations specified by the source parameter, along with any files in the
# working directory, into a temporary folder, and execute your Terraform commands in that folder.
terraform {
  source = "git::ssh://git-codecommit.eu-central-1.amazonaws.com/v1/repos/ttd-terraform.git//iam"
}

# Include all settings from the root terraform.tfvars file
include {
  path = find_in_parent_folders()
}

dependency "cognito_identity_pool" {
  config_path = "${get_terragrunt_dir()}/../../cognito/cognito-identity-pool/user"

  mock_outputs = {
    identity_pool_id = "user-identity-pool-id"
  }
  mock_outputs_allowed_terraform_commands = ["validate", "plan"]
}

dependency "pinpoint" {
  config_path = "${get_terragrunt_dir()}/../../pinpoint"

  mock_outputs = {
    application_id = "user-pinpoint-application-id"
  }
  mock_outputs_allowed_terraform_commands = ["validate", "plan"]
}

# ---------------------------------------------------------------------------------------------------------------------
# MODULE PARAMETERS
# These are the variables we have to pass in to use the module specified in the terragrunt configuration above
# ---------------------------------------------------------------------------------------------------------------------

inputs = {
  name                             = "user"
  identity_pool_id                 = dependency.cognito_identity_pool.outputs.identity_pool_id
  authenticated_assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "cognito-identity.amazonaws.com"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
          "cognito-identity.amazonaws.com:aud": "${dependency.cognito_identity_pool.outputs.identity_pool_id}"
        },
        "ForAnyValue:StringLike": {
          "cognito-identity.amazonaws.com:amr": "authenticated"
        }
      }
    }
  ]
}
EOF
  authenticated_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "cognito-identity:*"
      ],
      "Resource": [
        "*"
      ]
    },
    {
        "Effect": "Allow",
        "Action": [
            "mobiletargeting:UpdateEndpoint",
            "mobiletargeting:PutEvents"
        ],
        "Resource": [
            "arn:aws:mobiletargeting:*:${get_aws_account_id()}:apps/${dependency.pinpoint.outputs.application_id}/*"
        ]
    }
  ]
}
EOF
  unauthenticated_assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "cognito-identity.amazonaws.com"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
          "cognito-identity.amazonaws.com:aud": "${dependency.cognito_identity_pool.outputs.identity_pool_id}"
        },
        "ForAnyValue:StringLike": {
          "cognito-identity.amazonaws.com:amr": "unauthenticated"
        }
      }
    }
  ]
}
EOF
  unauthenticated_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "cognito-identity:*"
      ],
      "Resource": [
        "*"
      ]
    },
    {
        "Effect": "Allow",
        "Action": [
            "mobiletargeting:UpdateEndpoint",
            "mobiletargeting:PutEvents"
        ],
        "Resource": [
            "arn:aws:mobiletargeting:*:${get_aws_account_id()}:apps/${dependency.pinpoint.outputs.application_id}/*"
        ]
    }
  ]
}
EOF
}
