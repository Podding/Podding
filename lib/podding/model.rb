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

    split_content = split_content_and_meta(content_path)
    @content = split_content[:content]
    @meta_data = split_content[:meta_data]
  end

  def template
    if @meta_data["template"]
      @meta_data["template"].to_sym
    else
      default_template
    end
  end

  def default_template
    raise NotImplementedError
  end

  def content_path
    raise NotImplementedError
  end

  # Dynamic meta data lookup
  def method_missing(meth, *args, &block)
    key = meth.to_s
    if @meta_data.has_key?(key)
      @meta_data[key]
    else
      nil
    end
  end

  def respond_to?(meth)
    @meta_data.has_key?(meth)
  end

end
