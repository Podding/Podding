# encoding: utf-8

Dir[File.dirname(__FILE__) + "/*.rb"].each do |route|
  if route != __FILE__
    require_relative route
  end
end
