# encoding: utf-8

class Podding < Sinatra::Base

  get "/shows/:name" do |name|
    @show = ShowModel.new(name: name, path: settings.episodes)
    slim @show.template
  end

end

