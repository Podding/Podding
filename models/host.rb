# encoding: utf-8

class Host < Model

  def initialize(options = {})
    @name = options[:name]
    super(options)
  end

  def content_path
    @path
  end

  def default_template
    :hosts
  end
end
