require 'spec_helper'

describe HomeController do

  it 'should render the index page' do
    get :index
    response.should be_success
  end

end
