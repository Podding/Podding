# encoding: utf-8

class Podding < Sinatra::Base

  get "/pages/:name" do |name|
    @page = PageModel.new(name: name, path: settings.pages)
    slim @page.template
  end

end
