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

def with_authenticated_request
  # @request.headers['HTTP_BASIC'] # TODO: encode http basic auth here
end
