inputs = {
  provider_name     = "Facebook"
  provider_type     = "Facebook"
  authorize_scopes  = "public_profile, email"
  attribute_mapping = {
                        email    = "email"
                        username = "id"
                      }
  provider_details  = {
                        attributes_url                = "https://graph.facebook.com/v6.0/me?fields="
                        attributes_url_add_attributes = "true"
                        authorize_url                 = "https://www.facebook.com/v6.0/dialog/oauth"
                        token_request_method          = "GET"
                        token_url                     = "https://graph.facebook.com/v6.0/oauth/access_token"
                      }
}