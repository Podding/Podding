# encoding: utf-8

class Podding < Sinatra::Base
  get "/git" do
    "Hallo Hugo"
  end

  post "/git" do
    push = JSON.parse(params[:payload])
    #"I got some JSON: #{push.inspect}"
    `git submodule foreach git pull origin master`
  end

end
