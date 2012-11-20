
module Episode
  include Helper

  def render_markdown(name)
    path = "#{settings.views}/#{name}"
    content = File.read(path).force_encoding('UTF-8')
    markdown content
  end

  def render_episode(name)
    locals = load_yaml(name)
    slim :"includes/_episode-header", :locals => locals
  end

  def load_yaml(name)
    data = ""
    content = load_file(name)

    begin
      if content =~ /^(---\s*\n.*?\n?)^(---\s*$\n?)/m
        content = $POSTMATCH
        data = YAML.load($1)
      else
        raise "No YAML meta data header found in #{path}"
      end
    rescue => e
      raise "YAML Exception reading #{path}: #{e.message}"
    end

    data
  end

  def load_file(name)
    path = "#{settings.views}/episodes/#{name}"

    File.read(path).force_encoding('UTF-8')
  end

  module_function :render_episode
end
