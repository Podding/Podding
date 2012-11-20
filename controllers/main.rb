# encoding: utf-8

class Podding < Sinatra::Base

  not_found do
    slim :"404"
  end

  # Debug route so we can test-render templates

  get "/debug/*" do |template|
    slim template.to_sym
  end

end

