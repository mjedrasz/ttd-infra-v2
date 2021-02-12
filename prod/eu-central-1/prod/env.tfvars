# Root level variables that all modules can inherit. This is especially helpful with multi-account configs
# where terraform_remote_state data sources are placed directly into the modules.

aws_env                                 = "prod"
default_tags                            = {
                                            "project" = "ttd"
                                            "env"     = "prod" }
