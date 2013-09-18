# encoding: utf-8

Dir[File.dirname(__FILE__) + "/*.rb"].each do |filter|
  if filter != __FILE__
    require_relative filter
  end
end
