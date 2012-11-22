# encoding: utf-8

class Podding < Sinatra::Base

  # Special pages

  get "/pages/archive" do
    @episodes = Episode.all
    slim :archive
  end

  get "/pages/hosts" do
    @hosts = Host.all
    slim :hosts
  end

  get "/pages/hosts/:name" do |name|
    @hosts = Host.find(by: "handle", value: name)
    slim :hosts
  end

  get "/pages/:name" do |name|
    @page = Page.new(name: name)
    slim @page.template
  end

end
