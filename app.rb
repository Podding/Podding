#!/usr/bin/env ruby
# encoding: utf-8

if "1.9".respond_to?(:encoding)
  Encoding.default_external = 'UTF-8'
  Encoding.default_internal = 'UTF-8'
end

require 'bundler/setup'
require 'sinatra/base'
require 'sinatra/assetpack'
require 'sinatra/config_file'
require 'slim'
require 'less'
require 'redcarpet'
require 'net/http'
require 'net/https'
require 'json'

require_relative 'lib/podding'

class Podding < Sinatra::Base
  register Sinatra::ConfigFile

  enable :sessions, :static, :logging

  source_dir = File.dirname(__FILE__) + '/source'
  config_file "#{ source_dir }/config.yaml"

  set :root, File.dirname(__FILE__)
  register Sinatra::AssetPack

  set :public_folder, source_dir + '/assets'
  set :views, source_dir + '/templates'

  FileStorage.base_path = source_dir
  Model.storage_engine = FileStorage

  configure :production do
    # ...
  end

  configure :development do
    require 'pry'
    require 'pry-nav'
  end

  helpers do
    include Rack::Utils
    alias_method :h, :escape_html
  end

  require_relative 'controllers/init'
  require_relative 'models/init'
  require_relative 'helpers/init'

  Less.paths << source_dir + "/css"

  assets do
    serve '/js',     from: 'source/js'
    serve '/css',    from: 'source/css'
    serve '/images', from: 'source/images'
  end

  # Load all helpers

  Helper.defined_helpers.each do |helper|
    helpers helper
  end

  # Index all models

  searchIndex = Hash.new
  Model.defined_models.each do |model|
    model.index_all searchIndex
  end

  run! if app_file == $0
end

