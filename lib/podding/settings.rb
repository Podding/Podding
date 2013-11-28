# encoding: utf-8

require 'settingslogic'

class Settings < Settingslogic
  source "#{File.dirname(__FILE__)}/../../source/config.yaml"
  load!
end