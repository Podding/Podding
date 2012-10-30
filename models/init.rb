# encoding: utf-8

Dir[File.dirname(__FILE__) + "/*.rb"].each do |model|
  require_relative model
end
