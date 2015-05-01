# encoding: utf-8

require 'date'

class Episode < Mlk::Model
  belongs_to :Show, :show

  attr_reader :teaser

  attribute :comments
  attribute :subtitle
  attribute :title, -> { 'Untitled' }

  def self.sorted
    all.sort_by(:date)
  end

  def initialize(document, options = {})
    super
    set_teaser
  end

  def date
    Date.parse(data['date'].to_s)
  end

  def year
    date.year
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
    #deprecated, will be removed as soon as templates are clean
    'published'
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

end