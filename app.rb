#!/usr/bin/env ruby -w
# encoding: utf-8

require 'bundler/setup'
require 'sinatra/base'
require 'slim'
require 'less'
require 'redcarpet'

require_relative 'lib/helper'

class Podding < Sinatra::Base
  enable :sessions, :static, :logging

  base_dir = File.dirname(__FILE__)

  set :public_folder, base_dir + '/source/assets'
  set :views, base_dir + '/source'

  configure :production do
    set :clean_trace, true
    set :css_files, :blob
    set :js_files,  :blob
  end

  configure :development do
    # ...
  end

  helpers do
    include Rack::Utils
    alias_method :h, :escape_html
  end

  require_relative 'routes/init'
  require_relative 'models/init'
  require_relative 'helpers/init'

  run! if app_file == $0
end

