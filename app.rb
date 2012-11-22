#!/usr/bin/env ruby
# encoding: utf-8

if "1.9".respond_to?(:encoding)
  Encoding.default_external = 'UTF-8'
  Encoding.default_internal = 'UTF-8'
end

require 'bundler/setup'
require 'sinatra/base'
require 'sinatra/assetpack'
require 'slim'
require 'less'
require 'redcarpet'
require 'ohm'

require_relative 'lib/podding'

class Podding < Sinatra::Base
  enable :sessions, :static, :logging

  source_dir = File.dirname(__FILE__) + '/source'

  set :root, File.dirname(__FILE__)
  register Sinatra::AssetPack

  set :public_folder, source_dir + '/assets'
  set :views, source_dir + '/templates'
  set :pages, source_dir + '/pages'
  set :hosts, source_dir + '/hosts'
  set :episodes, source_dir + '/episodes'

  configure :production do
    # ...
  end

  configure :development do
    # ...
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

  run! if app_file == $0
end

