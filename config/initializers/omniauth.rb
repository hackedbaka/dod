Rails.application.config.middleware.use OmniAuth::Builder do
OmniAuth.config.logger = Rails.logger
provider :google_oauth2,
    ENV['OAUTH_CLIENT_ID'],
    ENV['OAUTH_CLIENT_SECRET'], {
    # redirect_uri:"http://localhost:3000/auth/google_oauth2/callback"
    # redirect_uri:"https://doubleordonate.herokuapp.com/auth/google_oauth2/callback"
}
    
  # provider :google_oauth2, '730973355649-vu2o61sssrjbklu4fo6imilnufuf9g19.apps.googleusercontent.com', 'KAWMdEBZ5wUSovfM3N1QHiLj'
   # {:client_options => {:ssl => {:ca_file => "/usr/local/etc/openssl/cert.pem"}}}
end
