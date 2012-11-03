# encoding: utf-8

class Podding < Sinatra::Base

  get "/" do
    slim :index
  end

  get "/pages/:name" do |name|
    slim "pages/#{name}".to_sym
  end

end

