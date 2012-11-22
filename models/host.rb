# encoding: utf-8

class Host < Model

  class << self

    def all(options = {})
      host_paths = scan_hosts(options[:path])

      host_paths.map do |path|
        Host.new(path: path)
      end
    end

    def find(options = {})
    end

    def scan_hosts(base_path)
      path = "#{base_path}/*.md"
      Dir[path]
    end

  end

  def initialize(options = {})
    super(options)
  end

  def content_path
    @path
  end

  def default_template
    :hosts
  end

end
