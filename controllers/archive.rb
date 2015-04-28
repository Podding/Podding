# encoding: utf-8

class Podding < Sinatra::Base

  get "/archive" do
    @page = Page.first(name: "archive")

    all_episodes = Episode.sorted.reverse
    @episodes = all_episodes.group_by(:year)

    slim :archive

  end

end

