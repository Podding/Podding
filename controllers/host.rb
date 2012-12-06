# encoding: utf-8

class Podding < Sinatra::Base

  get "/hosts" do
    @page = Page.new(name: "hosts")
    @hosts = Host.all
    slim :hosts
  end

  get "/hosts/:name" do |name|
    @page = Page.new(name: "hosts")
    @hosts = Host.find(name: name)
    slim @hosts.first.template
  end

end
