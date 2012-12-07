# encoding: utf-8

class Podding < Sinatra::Base

  # Special pages

  get "/pages/archive" do
    @page = Page.first(name: "archive")
    @episodes = Episode.all
    slim :archive
  end

  get "/pages/:name" do |name|
    @page = Page.first(name: name)
    slim @page.template
  end

end
