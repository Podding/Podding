# encoding: utf-8

class Podding < Sinatra::Base

  get "/" do
    slim :index
  end

  not_found do
    slim :"404"
  end

  get "/pages/:name" do |name|
    slim "pages/#{name}".to_sym
  end

  get "/shows/:show" do |show|
    ShowController.new(show).render
  end

  get "/shows/:show/:name" do |show, name|
    ShowController.new(show).render(name)
  end

  # Debug route so we can test-render templates

  get "/debug/*" do |template|
    slim template.to_sym
  end

end

