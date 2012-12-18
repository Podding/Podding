# encoding: utf-8

class Podding < Sinatra::Base

  get "/" do
    @live_episodes = Episode.find(status: "live")
    @published_episodes = Episode.find(status: "published")
    @planned_episodes = Episode.find(status: "planned")
    slim :index
  end

end

