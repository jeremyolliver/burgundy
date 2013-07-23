class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authenticate_if_required

  protected

  def configuration
    Burgundy::Configuration.config
  end

  def authenticate_if_required
    if configuration.authentication_enabled?
      unless authenticate_with_http_basic { |u, p| u == configuration.authenticated?(u, p) }
        request_http_basic_authentication('Burgundy')
      end
    end
  end

end
