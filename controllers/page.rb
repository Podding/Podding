# encoding: utf-8

class Podding < Sinatra::Base

  # Special pages

  get "/pages/archive" do
    @episodes = EpisodeModel.all(path: settings.episodes)
    slim :archive
  end

  get "/pages/:name" do |name|
    @page = PageModel.new(name: name, path: settings.pages)
    slim @page.template
  end

end
