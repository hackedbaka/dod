OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, '730973355649-vu2o61sssrjbklu4fo6imilnufuf9g19.apps.googleusercontent.com', 'KAWMdEBZ5wUSovfM3N1QHiLj'

  provider :twitter, 'xdwyNEyCVzUTPjdEzqkSR7hfo', 'k6k5OPrcDmURrlCM8hveU5tTmESXTzkoYGZf1UvE8spwl4skjl'
  OmniAuth.config.on_failure = Proc.new do |env|
    SessionsController.action(:auth_failure).call(env)
  end
end
