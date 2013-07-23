require 'spec_helper'

describe HomeController do

  it 'should render the index page' do
    get :index
    response.should be_success
  end

  describe 'with authentication enabled' do
    before do
      with_authentication_enabled
    end
    after do
      with_default_config
    end

    it 'should deny unauthenticated access' do
      get :index
      response.should_not be_successful
      response.status.should eq(401) # Unauthorized
    end

    it 'should allow an authenticated user' do
      with_authenticated_request
      Burgundy::Configuration.config.should be_authentication_enabled
      get :index
      response.should be_successful
    end
  end

end
