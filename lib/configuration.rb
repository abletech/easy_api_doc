require 'yaml'

class Configuration

  attr_accessor :options

  def self.load
    if Rails.env.development?
      Configuration.new
    else
      @@config ||= Configuration.new
    end
  end

  def initialize
    config_file = File.join('doc', 'api_doc.yml')
    Rails.logger.info("Loading EasyApiDoc configuration file #{config_file}")

    @options = YAML.load(File.read(config_file))
  end

  # Allow straight hash access to the options
  def [](key)
    @options[key]
  end

  # def []=(key, value)
  #   @options[key] = value
  # end

end
