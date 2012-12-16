#encoding: utf-8

class Podding < Sinatra::Base
  get "/feed/:show_name/:audio_format/feed.xml" do |show_name, audio_format|
    @episodes = Episode.find_match(show: show_name)
    @show = Show.first(name: show_name)
    @audio_format = audio_format
    builder :atom
  end

  get "/feed/:audio_format/feed.xml" do |audio_format|
    @episodes = Episode.find_match(:audioformats => audio_format)
    @audio_format = audio_format
    @episodes.inspect.to_s
    builder :atom
  end
end
