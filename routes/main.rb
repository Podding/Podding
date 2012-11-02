# encoding: utf-8

class Podding < Sinatra::Base

  get "/" do
    slim :index
  end

end

