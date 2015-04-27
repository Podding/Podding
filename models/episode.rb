# encoding: utf-8

require 'date'

class Episode < Mlk::Model
  belongs_to :Show, :show

  attr_reader :teaser

  attribute :comments
  attribute :subtitle
  attribute :title, -> { 'Untitled' }

  def self.default_sort_by
    :date
  end

  def initialize(document, options = {})
    super
    set_teaser
  end

  def date
    Date.parse(data['date'].to_s)
  end

  def live_date
    Date.parse(data['live_date']) if data['live_date']
  end

  def audioformats
    if data['audioformats'].nil?
      return show.audioformats
    end

    data['audioformats'].map do |format|
      Audioformat.first(:name => format)
    end
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

  def hosts
    # TODO: only support plural attribute
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

  def audio_files # returns a hash: audioformat: url
    audioformats.each_with_object({ }) do |format, result|
      result[format] = audiopath_for_format(format)
    end
  end

  def audio_file_by_format(format)
    audio_files[format]
  end

  def number
    name.split("-",2)[1]
  end

  def content
    @content || document.content
  end

  private

  def set_teaser
    if match = content.match(/^(!!!\s*\n(.*?)\n?)^(!!!\s*$\n?)(.*)/m)
      @teaser = match[2]
      @content = match[4]
    else
      @teaser = ''
    end
  end

  def audiopath_for_format(format)
    # TODO: use settings for base bath
    "/audio/#{ self.name }#{ format.file_extension }"
  end

end

