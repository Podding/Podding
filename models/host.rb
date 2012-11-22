# encoding: utf-8

class Host < Model

  class << self

    def all(options = {})
      host_paths = scan_files

      host_paths.map do |path|
        Host.new(path: path)
      end
    end

    def find(options = {})
      hosts = all(options)
      hosts.select do |host|
        host.meta_data[options[:by]] == options[:value]
      end
    end

  end

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
