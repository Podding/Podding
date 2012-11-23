# encoding: utf-8

class Podding < Sinatra::Base

  get "/hosts" do
    @hosts = Host.all
    slim :hosts
  end

  get "/hosts/:name" do |name|
    @hosts = Host.find(by: "handle", value: name)
    slim :hosts
  end

end
