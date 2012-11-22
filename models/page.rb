# encoding: utf-8

class Page < Model

  class << self

    def all(options = {})
    end

    def find(options = {})
    end

  end

  def initialize(options = {})
    @name = options[:name]

    super(options)
  end

  def content_path
    "#{ @path }/#{ @name }.md"
  end

  def default_template
    :page
  end

end
