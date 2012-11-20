# encoding: utf-8

module ReadContent

  def split_content_and_meta(path)
    data = ""
    content = File.read(path)

    begin
      if match = content.match(/^(---\s*\n(.*?)\n?)^(---\s*$\n?)(.*)/m)
        data = YAML.load(match[2])
        content = match[4]
      else
        data = { }
      end
    rescue => e
      raise "YAML Exception reading #{path}: #{e.message}"
    end

    { content: content, meta_data: data }
  end

end
