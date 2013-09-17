# encoding: utf-8

class Settings
  attr_reader :settings # for testing

  def initialize(settings_file)
    @settings = YAML.load(settings_file)
  end

  def method_missing(method, *args)
    lookup_string = method.to_s
    return @settings[lookup_string] if @settings.has_key?(lookup_string)
    return nil
  end

end