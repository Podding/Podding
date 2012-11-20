# encoding: utf-8

class Podding < Sinatra::Base

  get "/" do
    @episodes = EpisodeModel.all(path: settings.episodes)
    slim :index
  end

end

