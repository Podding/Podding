# encoding: utf-8

class Model
  include ReadContent

  attr_reader :content, :meta_data

  class << self

    attr_accessor :base_path

    def all(options = {})
      raise NotImplementedError
    end

    def find(options = {})
      models = all(options)
      models.select do |model|
        model.meta_data[options[:by]] == options[:value]
      end
    end

    def path
      name = self.name.downcase + "s"
      "#{ Model.base_path }/#{ name }"
    end

    def scan_files
      files = "#{ path }/**/*.md"
      Dir[files]
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

    return super if @meta_data.nil?

    if @meta_data.has_key?(key)
      @meta_data[key]
    else
      nil
    end
  end

  def respond_to?(meth)
    if @meta_data && @meta_data.has_key?(meth)
      true
    else
      super
    end
  end

end
