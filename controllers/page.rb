# encoding: utf-8

class Podding < Sinatra::Base

  # Special pages

  get "/pages/archive" do
    @episodes = Episode.all
    slim :archive
  end

  get "/pages/:name" do |name|
    @page = Page.new(name: name)
    slim @page.template
  end

end
