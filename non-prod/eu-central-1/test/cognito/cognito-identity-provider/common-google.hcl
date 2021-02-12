inputs = {
  provider_name     = "Google"
  provider_type     = "Google"
  authorize_scopes  = "email openid"
  attribute_mapping = {
                        email    = "email"
                        username = "sub"
                      }
  provider_details  = {
                        attributes_url                = "https://people.googleapis.com/v1/people/me?personFields="
                        attributes_url_add_attributes = "true"
                        authorize_url                 = "https://accounts.google.com/o/oauth2/v2/auth"
                        oidc_issuer                   = "https://accounts.google.com"
                        token_request_method          = "POST"
                        token_url                     = "https://www.googleapis.com/oauth2/v4/token"
                      }
}