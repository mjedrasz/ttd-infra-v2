# Root level variables that all modules can inherit. This is especially helpful with multi-account configs
# where terraform_remote_state data sources are placed directly into the modules.


tfstate_cognito_user_pool_bucket        = "eu-central-1/prod/cognito/cognito-user-pool/terraform.tfstate"
tfstate_cognito_user_pool_client_bucket = "eu-central-1/prod/cognito/cognito-user-pool-client/terraform.tfstate"
tfstate_s3_assets_bucket                = "eu-central-1/prod/s3/assets/terraform.tfstate"
tfstate_s3_organiser_ui_bucket          = "eu-central-1/prod/s3/organiser-ui/terraform.tfstate"
tfstate_s3_pwa_ui_bucket                = "eu-central-1/prod/s3/pwa-ui/terraform.tfstate"
tfstate_cloudfront_bucket               = "eu-central-1/prod/cloudfront/terraform.tfstate"
tfstate_pinpoint_bucket                 = "eu-central-1/prod/pinpoint/terraform.tfstate"
tfstate_dynamodb_bucket                 = "eu-central-1/prod/dynamodb/terraform.tfstate"
aws_env                                 = "prod"
default_tags                            = {
                                            "project" = "ttd"
                                            "env" = "prod" }
