# encoding: utf-8

class Episode < Model

  class << self

    def all(options = {})
      episode_paths = scan_episodes(options[:path])
      episode_paths = episode_paths.last(options[:limit]) if options[:limit]

      index(:episode_paths => episode_paths)

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

    def index(options = {})
      episode_paths = options[:episode_paths]
      episode_index = {}

      episode_paths.each do |episode|

        begin
          parsed_episode = load_yaml(episode)
        rescue => e
          puts e
          next
        end

        parsed_episode.keys.each do |attribute_key|
          if not episode_index.key? attribute_key
            episode_index[attribute_key] = {}
          end

          if not episode_index[attribute_key].key? parsed_episode[attribute_key]
            episode_index[attribute_key][parsed_episode[attribute_key]] = []
          end

          episode_index[attribute_key][parsed_episode[attribute_key]] << episode
        end
      end

      @@episode_index == episode_index
    end

    def load_yaml(name)
      data = ""
      content = load_file(name)

      begin
        if content =~ /^(---\s*\n.*?\n?)^(---\s*$\n?)/m
          content = $POSTMATCH
          data = YAML.load($1)
        else
          raise "No YAML meta data header found in #{name}"
        end
      rescue => e
        raise "YAML Exception reading #{name}: #{e.message}"
      end

      data
    end

    def load_file(name)
      File.read(name).force_encoding('UTF-8')
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
