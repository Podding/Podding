# encoding: utf-8

class Podding < Sinatra::Base

  get "/pages/:name" do |name|
    @page = Page.first(name: name)
    if @page.is_special
      redirect to('/' + name)
    end
    slim @page.template
  end

end
