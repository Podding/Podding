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

base_dir = File.dirname(__FILE__)

Mlk::FileStorage.base_path = File.join(base_dir, '/source')
Mlk::Model.storage_engine = Mlk::FileStorage

Podding.set :views, File.join(base_dir, '/source/templates')

def validate_meta_data(url, options)
  get url
  options.each do |key, value|
    assert_match %r{<p>#{ key }: #{ value }</p>}, last_response.body
  end
end

