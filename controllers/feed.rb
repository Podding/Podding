#encoding: utf-8

class Podding < Sinatra::Base
  get "/feed/:show_name/:audio_format/feed" do |show_name, audio_format|
    @episodes = []
    Episode.all.each do |episode|
      @episodes << episode if episode.audioformats.include?(audio_format) and episode.show.name == show_name
    end
    @show = Show.first(name: show_name)
    @audioformat = Audioformat.first(name: audio_format)
    builder :rss
  end

  get "/feed/:audio_format/feed" do |audio_format|
    @episodes = []
    Episode.all.each do |episode|
      @episodes << episode if episode.audioformats.include?(audio_format)
    end
    @audioformat = Audioformat.first(name: audio_format)
    @episodes.inspect.to_s
    builder :rss
  end

  get "feed/itunes" do
    redirect "feed/aac/feed"
  end
end