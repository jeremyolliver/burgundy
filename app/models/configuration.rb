class Configuration

  class << self
    attr_accessor :config_instance

    def config
      self.config_instance ||= Configuration.new
    end

    def defaults
      {
        authentication: {
          enabled: false
        }
      }
    end
  end

  def initialize
    reload!
  end

  def reload!
    @attributes = Configuration.defaults
    load_from_config_file
  end

  def [](key)
    @attributes[key.to_sym]
  end

  def []=(key, value)
    if value.class == Hash
      @attributes[key.to_sym] = Config.new(value)
    else
      @attributes[key.to_sym] = value
    end
  end

  private

  def load_from_config_file(file = './config/config.yml')
    if File.exists?(file)
      settings = YAML.load_file(file)
      update!(settings)
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
