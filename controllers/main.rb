# encoding: utf-8

class Podding < Sinatra::Base

  get "/" do
    slim :index
  end

  not_found do
    slim :"404"
  end

  get "/shows/:show" do |show|
    "show"
  end

  get "/shows/:show/:name" do |show, name|
    "show"
  end

  # Debug route so we can test-render templates

  get "/debug/*" do |template|
    slim template.to_sym
  end

end

