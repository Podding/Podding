# encoding: utf-8

class Podding < Sinatra::Base

  get "/" do
    @episodes = Episode.all
    slim :index
  end

end

