# Root level variables that all modules can inherit. This is especially helpful with multi-account configs
# where terraform_remote_state data sources are placed directly into the modules.

tfstate_cognito_user_pool_bucket        = "eu-central-1/test/cognito/cognito-user-pool/terraform.tfstate"
tfstate_cognito_user_pool_client_bucket = "eu-central-1/test/cognito/cognito-user-pool-client/terraform.tfstate"
tfstate_s3_assets_bucket                = "eu-central-1/test/s3/assets/terraform.tfstate"
tfstate_s3_organiser_ui_bucket          = "eu-central-1/test/s3/organiser-ui/terraform.tfstate"
tfstate_s3_pwa_ui_bucket                = "eu-central-1/test/s3/pwa-ui/terraform.tfstate"
tfstate_cloudfront_bucket               = "eu-central-1/test/cloudfront/terraform.tfstate"
tfstate_pinpoint_bucket                 = "eu-central-1/test/pinpoint/terraform.tfstate"
tfstate_dynamodb_bucket                 = "eu-central-1/test/dynamodb/terraform.tfstate"
aws_region                              = "eu-central-1"
aws_env                                 = "local"

