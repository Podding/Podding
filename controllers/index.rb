# encoding: utf-8

class Podding < Sinatra::Base

  get "/" do
    @episodes = Episode.all(path: settings.episodes)
    slim :index
  end

end

