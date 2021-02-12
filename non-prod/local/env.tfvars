# Root level variables that all modules can inherit. This is especially helpful with multi-account configs
# where terraform_remote_state data sources are placed directly into the modules.

aws_region                              = "eu-central-1"
aws_env                                 = "local"

