require 'rubygems'
require 'bundler'
require 'bundler/setup'

root = ::File.dirname(__FILE__)
require ::File.join( root, 'app' )
run Podding.new
