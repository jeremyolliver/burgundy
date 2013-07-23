def with_authentication_enabled
  if block_given?
    prior_config = Burgundy::Configuration.config
    use_authenticated_config
    begin
      yield
    ensure
      Burgundy::Configuration.config_instance = prior_config
    end
  else
    use_authenticated_config
  end
end

def use_authenticated_config
  Burgundy::Configuration.config_instance = authenticated_config
  # Burgundy::Configuration.stub(:config).and_return authenticated_config
end

def with_default_config
  Burgundy::Configuration.config.reload!
end

def with_authenticated_request(username = nil, password = nil)
  username ||= Burgundy::Configuration.config[:authentication][:username]
  password ||= Burgundy::Configuration.config[:authentication][:password]
  request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(username, password)
end
