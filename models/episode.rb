# encoding: utf-8

class Episode < Model

  class << self

    def all(options = {})
      episode_paths = scan_files
      episode_paths = episode_paths.last(options[:limit]) if options[:limit]

      episode_paths.map do |episode_path|
        Episode.new(path: episode_path)
      end
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
