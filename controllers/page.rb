# encoding: utf-8

class Podding < Sinatra::Base

  # Special pages

  get "/pages/archive" do
    @episodes = Episode.all(path: settings.episodes)
    slim :archive
  end

  get "/pages/hosts" do
    @hosts = Host.all(path: settings.hosts)
    slim :hosts
  end

  get "/pages/hosts/:name" do |name|
    @hosts = Host.find(by: "handle", value: name, path: settings.hosts)
    slim :hosts
  end

  get "/pages/:name" do |name|
    @page = Page.new(name: name, path: settings.pages)
    slim @page.template
  end

end
