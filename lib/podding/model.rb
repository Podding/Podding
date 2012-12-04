# encoding: utf-8

class Model

  class << self

    attr_accessor :base_path

    def first(options = {})
      find(options).first
    end

    def find(options = {})
      all.select do |model|
        options.all? do |param, value|
          model.meta_data[param.to_s] == value
        end
      end
    end

    def find_match(options = {})
      all.select do |model|
        options.all? do |param, value|
          data = model.meta_data[param.to_s]
          case data
          when Enumerable then data.grep(value)
          when String, Regexp then data.match(value)
          end if data
        end
      end
    end

    def all
      all_files = scan_files

      all_files.map do |path|
        self.new(path: path)
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


  attr_reader :path, :content, :meta_data

  def initialize(options = {})
    @path = options[:path]
    split_content = split_content_and_meta(content_path)
    @content = split_content[:content]
    @meta_data = split_content[:meta_data]
  end

  def split_content_and_meta(path)
    data = ""
    content = File.read(path)

    begin
      if match = content.match(/^(---\s*\n(.*?)\n?)^(---\s*$\n?)(.*)/m)
        data = YAML.load(match[2])
        content = match[4]
      else
        data = { }
      end
    rescue => e
      raise "YAML Exception reading #{path}: #{e.message}"
    end

    { content: content, meta_data: data }
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
