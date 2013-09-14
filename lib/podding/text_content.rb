# encoding: utf-8

class TextContent
  attr_accessor :raw

  def initialize(content = "")
    @raw = content
  end

  def render(settings = {})
    rendered_content = String.new(@raw)
    filters = TextFilterEngine.filters.map{ |filter| filter.new(settings)}
    filters.each{ |filter| rendered_content = filter.render(rendered_content)}
    rendered_content
  end
end