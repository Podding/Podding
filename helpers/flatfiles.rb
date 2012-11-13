# encoding: utf-8

module Flatfile
  include Helper

  def index 
    episodeFiles = scan_episodes
    flat = {}
  
    episodeFiles.each do |episode|

      begin
        parsed_episode = load_yaml(episode)
      rescue => e
        puts e
        next
      end

      parsed_episode.keys.each do |attribute_key|
        if not flat.key? attribute_key
          flat[attribute_key] = {}
        end

        if not flat[attribute_key].key? parsed_episode[attribute_key]
          flat[attribute_key][parsed_episode[attribute_key]] = []
        end

        flat[attribute_key][parsed_episode[attribute_key]] << episode
      end
    end

    flat
  end

  def self.scan_episodes
    path = "./source/episodes/**/*.md"
    return Dir[path]
  end

  def self.load_yaml(name)
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

  def self.load_file(name)
    File.read(name).force_encoding('UTF-8')
  end

  module_function :index
end
