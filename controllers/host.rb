# encoding: utf-8

class Podding < Sinatra::Base

  get "/hosts" do
    @hosts = Host.all
    slim :hosts
  end

  get "/hosts/:handle" do |handle|
    @hosts = Host.find(handle: handle)
    slim :hosts
  end

end
