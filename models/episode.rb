# encoding: utf-8

require 'date'

class Episode < Model

  attr_reader :teaser

  attribute :title
  attribute :comments
  attribute :audioformats
  attribute :number

  belongs_to :show, :Show

  def self.default_sort_by
    :date
  end

  def initialize(document, options = {})
    super
    set_teaser
  end

  def date
    Date.parse(data['date'])
  end

  def live_date
    Date.parse(data['live_date']) if data['live_date']
  end

  def validate
    assert_present :date

    # Optional
    assert_present :live_date if self.live_date
  end

  def status
    if data['status'] # explicitly declared status takes precendence over date-based guesswork
      data['status']
    else
      if live_date and live_date == Date.today
      "live"
      elsif live_date and live_date > Date.today
        "planned"
      else
        if date <= Date.today
          "published"
        else
          "planned"
        end
      end
    end
  end

  def title
    if data['title']
      data['title']
    else
      "Untitled"
    end
  end

  def hosts
    if host_names = data['hosts']
      if host_names.respond_to?(:map)
        hosts = host_names.map do |host|
          Host.first(name: host)
        end
        # Filter nil hosts
        hosts.reject { |h| h.nil? }
      else
        Array(Host.first(name: host_names))
      end
    elsif host_name = data['host']
      Array(Host.first(name: host_name))
    else
      [ ]
    end
  end

  def audioformats # returns a hash: name: url
    if audioformats_data = data['audioformats'] # if declared in episode, use that
       if audioformats_data.is_a?(Hash) # if a hash is passed, assume that it contains full urls
         return audioformats_data
       elsif audioformats_data.is_a?(Array) # if an array is passed, look in audioformats for matching ones and build the hash
          
          audioformats_hash = Hash.new # this will contain name: url
          
          # now look up the corresponding Audioformat to each mentioned in the array and put them in a new array
          audioformats_array = Array.new
          audioformats_data.each do |format|
            audioformats_array << Audioformat.first(name: format)
          end

          # now use these to build the return hash
          audioformats_array.each do | audioformat |
            audioformats_hash[audioformat.name] = "/audio/" + self.name + audioformat.file_extension # to do: use settings for base bath
          end
          return audioformats_hash
       end

    elsif audioformats_array = self.show.audioformats # default to the ones declared in the episode
      audioformats_hash = Hash.new
      audioformats_array.each do | audioformat |
        audioformats_hash[audioformat.name] = "/audio/" + self.name + audioformat.file_extension # to do: use settings for base bath
      end
      return audioformats_hash

      # to do: use defaults from settings
    
    else # so, no audio for this episode... ;)
      {}
    end
  end # audioformats

  def number
    name.split("-",2)[1]
  end

  private

  def set_teaser
    if match = @content.match(/^(!!!\s*\n(.*?)\n?)^(!!!\s*$\n?)(.*)/m)
      @teaser = match[2]
      @content = match[4]
    else
      @teaser = ''
    end
  end

end
