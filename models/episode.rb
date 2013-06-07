# encoding: utf-8

require 'date'

class Episode < Model

  attr_reader :teaser

  attribute :title
  attribute :comments
  attribute :audioformats

  belongs_to :show, :Show

  def self.default_sort_by
    :date
  end

  def initialize(options)
    super(options)
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
