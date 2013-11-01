# encoding: utf-8

module Renderer
  include Helper

  def render_content(content, options = { })
    TextFilterEngine.render(content, options)
  end

end

