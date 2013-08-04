# encoding: utf-8

class Podding < Sinatra::Base

  get "/archive" do
    @page = Page.first(name: "archive")

    # workaround until the finding engine is properly implemented
    all_episodes = Episode.all
    episodes = []
    for episode in all_episodes
      if episode.status == "published"
        episodes << episode
      end
    end

    episodes.sort!{ |first, second| first.date <=> second.date }.reverse! # sort newest episodes first
    @episodes = episodes.group_by{ |episode| episode.date.year } # group them in a hash by year


    slim :archive

  end

end

