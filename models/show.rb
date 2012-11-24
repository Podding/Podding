# encoding: utf-8

class Show < Model

  def initialize(options = {})
    super(options)
  end

  def content_path
    @path
  end

  def default_template
    :shows
  end

end
