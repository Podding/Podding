# encoding: utf-8

class Host < Model

  def initialize(options = {})
    super(options)
  end

  def content_path
    @path
  end

  def default_template
    :hosts
  end

  def episodes
    Episode.find_match(host: [self.name])
  end

end
