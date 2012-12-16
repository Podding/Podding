# encoding: utf-8

class Podding < Sinatra::Base

  get "/shows" do
    @page = Page.first(name: "shows")
    @shows = Show.all
    slim :shows
  end

  get "/shows/:name" do |name|
    @page = Page.first(name: "shows")
    @show = Show.first(name: name)
    slim @show.template
  end

  get "/shows/:name/:episode_name" do |name, episode_name|
    @page = Page.first(name: "shows")
    @episode = Episode.first(name: episode_name)
    slim :episode
  end

end

