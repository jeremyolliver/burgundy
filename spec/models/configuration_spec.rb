require 'spec_helper'

describe Configuration do

  let(:config) { Configuration.config }

  it 'should have default values' do
    config[:authentication].should be_a Hash
    config[:authentication][:enabled].should be_false
  end
end
