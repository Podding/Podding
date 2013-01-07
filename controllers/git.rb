# encoding: utf-8

class Podding < Sinatra::Base

  post "/git" do
    push = JSON.parse(params[:payload])
    
    url = URI.parse("http://#{settings.varnish_host}:#{settings.varnish_port} /")
    req = Net::HTTP::VarnishBan.new(url.path)

    res = Net::HTTP.new(url.host, url.port).start do |http|
      http.request(req)
    end

    `git submodule foreach git pull origin master`
  end

end
