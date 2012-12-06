# encoding: utf-8

class Podding < Sinatra::Base

  get "/shows" do
    @page = Page.new(name: "shows")
    @shows = Show.all
    slim :shows
  end

  get "/shows/:name" do |name|
    @page = Page.new(name: "shows")
    @shows = Show.find(name: name)
    slim @shows.first.template
  end

end

