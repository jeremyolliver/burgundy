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

    it 'should deny unauthenticated access' do
      get :index
      binding.pry
      response.should_not be_successful
    end
  end

end
