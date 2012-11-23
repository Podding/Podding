# encoding: utf-8

class Episode < Model

  def initialize(options = {})
    super(options)
  end

  def content_path
    @path
  end

  def default_template
    :episode
  end
end
