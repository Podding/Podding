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

    def find(options = {})
      episodes = all(path: options[:path])

      episodes.select! do |episode|
        match = true

        options[:parameters].each do |parameter, value|
          if episode.meta_data[parameter.to_s] != value
            match = false
            break    
          end
        end
        
        match
      end
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
