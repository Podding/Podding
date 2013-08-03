# encoding: utf-8

class Podding < Sinatra::Base

  get "/shows" do
    @page = Page.first(name: "shows")
    @shows = Show.all
    slim :shows
  end

  get "/shows/:name" do |name|
    @show = Show.first(name: name)
    @pagetitle = @show.title
    slim @show.template
  end

  get "/shows/:name/:episode_name" do |name, episode_name|
    @episode = Episode.first(name: episode_name)
    @pagetitle = @episode.title
    slim @episode.template
  end

end

