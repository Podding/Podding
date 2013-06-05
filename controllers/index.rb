# encoding: utf-8

class Podding < Sinatra::Base

  get "/" do
    episodes = Episode.all
    @live_episodes = []
    @published_episodes = []
    @planned_episodes = []
    for episode in episodes do |episode|
      if episde.status == "published"
        @published_episodes << episode
      elsif episode.status == "live"
        @live_episodes << episode
      else
        @planned_episodes << episode
      end
    end
    slim :index
  end

end

