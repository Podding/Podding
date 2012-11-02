# encoding: utf-8

Dir[File.dirname(__FILE__) + "/*.rb"].each do |helper|
  if helper != __FILE__
    require_relative helper
  end
end

Helper.defined_helpers.each do |helper|
  puts "Loading helper #{helper}"
  Podding.helpers helper
end
