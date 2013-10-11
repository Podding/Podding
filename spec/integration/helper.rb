# encoding: utf-8

ENV['RACK_ENV'] = 'test'

require 'minitest/autorun'
require 'rack/test'
require 'nokogiri'

require 'pry'
require 'pry-byebug'

require_relative '../../app'

include Rack::Test::Methods

def app
  Podding
end

FileStorage.base_path = File.dirname(__FILE__) + '/source'
Model.storage_engine = FileStorage
Podding.set :views, File.dirname(__FILE__) + '/source/templates'

def validate_meta_data(url, options)
  get url
  options.each do |key, value|
    assert_match %r{<p>#{ key }: #{ value }</p>}, last_response.body
  end
end

