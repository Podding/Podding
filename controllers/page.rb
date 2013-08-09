# encoding: utf-8

class Podding < Sinatra::Base

  get "/pages/:name" do |name|
    @page = Page.first(name: name)
    slim @page.template
  end

end
