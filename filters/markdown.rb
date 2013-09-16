# A TextFilter that converts markdown to html using redcarpet

require 'redcarpet'

class MarkdownFilter < TextFilter
	priority 0

	def render(content)
		renderer = Redcarpet::Markdown.new(Redcarpet::Render::HTML, :autolink => true, :space_after_headers => true)
		renderer.render(content)
	end
end

TextFilterEngine.register_filter(MarkdownFilter)