# encoding: utf-8

class Podding < Sinatra::Base

  get "/shows" do
    @shows = Show.all
    slim :shows
  end

  get "/shows/:name" do |name|
    @shows = Show.find(by: "name", value: name)
    slim @shows.first.template
  end

end

