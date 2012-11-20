# encoding: utf-8

class PageModel < Model
  include ReadContent

  class << self

    def all(options = {})
    end

    def find(options = {})
    end

  end

  attr_reader :content, :meta_data

  def initialize(options = {})
    @path = options[:path]
    @name = options[:name]

    split_content = split_content_and_meta(content_path)
    @content = split_content[:content]
    @meta_data = split_content[:meta_data]
  end

  def content_path
    "#{ @path }/#{ @name }.md"
  end

  def template
    if @meta_data[:template]
      "templates/#{@meta_data[:template]}".to_sym
    else
      "templates/page".to_sym
    end
  end

end
