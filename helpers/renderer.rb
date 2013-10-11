# encoding: utf-8

module Renderer

  def render(content, options = { })
    TextFilterEngine.render(content, options)
  end

end

