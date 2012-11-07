# encoding: utf-8

Dir[File.dirname(__FILE__) + "/*.rb"].each do |controller|
  if controller != __FILE__
    require_relative controller
  end
end

