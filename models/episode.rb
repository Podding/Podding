# encoding: utf-8

require 'date'

class Episode < Model

  attr_reader :teaser

  attribute :title
  attribute :comments
  attribute :audioformats

  belongs_to :Show, :show

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
    assert_present :audioformats

    # Optional
    assert_present :live_date if self.live_date
  end

  def status
    if data['status']
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
    if formats_data = data['audioformats']
      if formats_data.is_a?(Hash)
        formats_data
      elsif formats_data.is_a?(Array)
        audioformats = formats_data.map { |format| Audioformat.first(name: format) }
        audioformats_to_hash(audioformats)
      end
    elsif audioformats = self.show.audioformats
      audioformats_to_hash(audioformats)
    else
      # TODO: use defaults from settings
      {}
    end
  end

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

  def audioformats_to_hash(formats)
    formats.each_with_object({ }) do |format, memo|
      memo[audioformat.name] = audiopath_for_format(format)
    end
  end

  def audiopath_for_format(format)
    # TODO: use settings for base bath
    "/audio/#{ self.name }#{ format.file_extension }"
  end

end

