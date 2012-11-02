# encoding: utf-8

Dir[File.dirname(__FILE__) + "/*.rb"].each do |model|
  if model != __FILE__
    require_relative model
  end
end

