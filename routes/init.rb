# encoding: utf-8

Dir[File.dirname(__FILE__) + "/*.rb"].each do |route|
  require_relative route
end
