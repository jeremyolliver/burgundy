require 'spec_helper'

describe Burgundy::Configuration do

  let(:default_config) { Burgundy::Configuration.config('nonexistent/config.yml') }

  it 'should have default values' do
    default_config[:authentication].should be_a Hash
    default_config[:authentication][:enabled].should be_false
  end

  it 'should load config from YAML' do
    config = Burgundy::Configuration.new('spec/files/config.yml')
    config[:access_key_id].should eq('test_env_key')
    config[:secret_access_key].should eq('default_secret_access_key')
  end

  it 'should load from non-namespaced YAML' do
    config = Burgundy::Configuration.new('spec/files/configplain.yml')
    config[:access_key_id].should eq('simple_key_id')
    config[:secret_access_key].should eq('simple_secret_access_key')
  end

end
