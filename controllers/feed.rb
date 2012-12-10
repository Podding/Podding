#encoding: utf-8

class Podding < Sinatra::Base
  get "/feed/:show_name/:audio_format/feed.xml" do
    @episodes = Episode.find_match(show: params[:show_name])
    @audio_format = params[:audio_format]
    @show = Show.find(name: params[:show_name])
    
    builder :atom
  end

  get "/feed/:audio_format/feed.xml" do
    @episodes = Episode.all
    @audio_format = params[:audio_format]
    @show = Show.all

    builder :atom
  end
end
