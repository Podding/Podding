# encoding: utf-8

class Episode < Model

  class << self

    def all(options = {})
      episode_paths = scan_episodes(options[:path])
      episode_paths = episode_paths.last(options[:limit]) if options[:limit]

      episode_paths.map do |path|
        Episode.new(path: path)
      end
    end

    def find(options = {})
    end

    def scan_episodes(base_path)
      path = "#{base_path}/**/*.md"
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
    :episode
  end

end
