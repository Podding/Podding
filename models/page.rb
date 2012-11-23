# encoding: utf-8

class Page < Model

  def initialize(options = {})
    @name = options[:name]

    super(options)
  end

  def content_path
    "#{ self.class.path }/#{ @name }.md"
  end

  def default_template
    :page
  end

end
