module Burgundy
  class Configuration

    class << self
      attr_accessor :config_instance

      def config(file = nil)
        self.config_instance ||= Configuration.new(file)
      end

      def defaults
        {
          authentication: {
            enabled: false
          }
        }
      end
    end

    def initialize(file = nil)
      reload!(file)
    end

    def authentication_enabled?
      self[:authentication][:enabled] && self[:authentication][:username].present? && self[:authentication][:password].present?
    end

    def authenticated?(username, password)
      return true unless self[:authentication][:enabled]
      username == self[:authentication][:username] && password == self[:authentication][:password]
    end

    def to_h
      @attributes.clone
    end

    def reload!(file = nil)
      @attributes = Configuration.defaults
      load_from_config_file(file)
    end

    def [](key)
      @attributes[key.to_sym]
    end

    def []=(key, value)
      key = key.to_sym
      if value.is_a? Hash
        @attributes[key] ||= {}
        @attributes[key].merge!(value)
      else
        @attributes[key] = value
      end
    end

    private

    def load_from_config_file(file = nil)
      file ||= './config/config.yml'
      if File.exists?(file)
        settings = YAML.load_file(file)
        config_to_load = settings.delete(Rails.env) || settings
        update!(config_to_load)
      else
        warn("Couldn't find configuration file #{file}")
      end
    end

    def update!(attributes = {})
      attributes.each do |key, value|
        self[key] = value
      end
    end


  end
end
