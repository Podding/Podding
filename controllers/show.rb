# encoding: utf-8

class Podding < Sinatra::Base

  get "/shows/:name" do |name|
    @show = Show.new(name: name, path: settings.episodes)
    slim @show.template
  end

end

