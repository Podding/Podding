# encoding: utf-8

class Model
  include ReadContent

  attr_reader :content, :meta_data

  class << self

    def all(options = {})
      raise NotImplementedError
    end

    def find(options = {})
      raise NotImplementedError
    end

  end

  def initialize(options = {})
    @path = options[:path]
    @name = options[:name]

    split_content = split_content_and_meta(content_path)
    @content = split_content[:content]
    @meta_data = split_content[:meta_data]
  end

  def template
    if @meta_data[:template]
      @meta_data[:template].to_sym
    else
      default_template
    end
  end

end
