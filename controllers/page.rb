# encoding: utf-8

class Podding < Sinatra::Base

  get "/pages/:name" do |name|
    content_dir = settings.views
    path = "#{content_dir}/pages"
    @model = PageModel.new(name: name, path: path)
    render_page
  end

  def render_page
    meta_data = @model.meta_data
    slim @model.template
  end

end
