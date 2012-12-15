# encoding: utf-8

class Podding < Sinatra::Base

  not_found do
    @page = Page.first(name: "404")
    slim @page.template
  end

  # Debug route so we can test-render templates

  get "/debug/*" do |template|
    slim template.to_sym
  end

end

