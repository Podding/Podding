# encoding: utf-8

ENV['RACK_ENV'] = 'test'

require 'minitest/autorun'
require 'minitest/benchmark'
require 'rack/test'

require_relative '../app'

include Rack::Test::Methods

def app
  Podding
end

Model.base_path = File.dirname(__FILE__) + '/source'
