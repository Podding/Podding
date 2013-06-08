# encoding: utf-8

class Document

  attr_reader :content, :data

  def initialize(raw_document, path = '')
    split_text = split_text_and_meta(raw_document, path)

    @content = split_text[:content]
    @data = split_text[:data]
  end

  def serialize
    "#{ self.data.to_yaml }\n---\n#{ self.content }"
  end

  def ==(other_document)
    meta_equals = self.data == other_document.data
    content_equals = self.content == other_document.content

    meta_equals && content_equals
  end

  private

  def split_text_and_meta(raw_document, path)
    content = ''
    data = { }

    begin
      if match = raw_document.match(/^(---\s*\n(.*?)\n?)^(---\s*$\n?)(.*)/m)
        data = YAML.load(match[2])
        content = match[4].strip
      else
        raise "No metadata header available in file: #{ path }! Document:\n#{ raw_document }"
      end
    rescue Psych::SyntaxError => e
      raise "YAML error while reading #{ path }: #{ e.message }"
    end

    { content: content, data: data }
  end

end

