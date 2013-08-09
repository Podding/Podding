# encoding: utf-8

class Podding < Sinatra::Base

  get "/archive" do
    @pagetitle = "Archive"

    # TODO: Use real finding engine
    all_episodes = Episode.all
    episodes = []
    for episode in all_episodes
      if episode.status == "published"
        episodes << episode
      end
    end

    episodes.sort!{ |first, second| first.date <=> second.date }.reverse!
    @episodes = episodes.group_by{ |episode| episode.date.year }

    slim :archive

  end

end

