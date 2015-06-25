OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
   provider :google_oauth2, ENV['GOOGLE_ID'], ENV['GOOGLE_SECRET'], 
    redirect_uri:"https://doubleordonate.herokuapp.com/auth/google_oauth2/callback"

  provider :twitter, ENV['twitter_id'], ENV['twitter_secret']
  OmniAuth.config.on_failure = Proc.new do |env|
    SessionsController.action(:auth_failure).call(env)
  end
end
