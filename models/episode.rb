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

  def validate
    assert_present :date
  end

  def status
    if date < Date.today
      "published"
    elsif date == Date.today
      "live"
    else
      "planned"
    end
  end

  def hosts
    if host_names = data['hosts']
      if host_names.respond_to?(:map)
        hosts = host_names.map do |host|
          Host.first(name: host)
        end
        # Filter nil hosts
        hosts.select { |h| !h.nil? }
      else
        Array(Host.first(name: host_names))
      end
    elsif host_name = data['host']
      Array(Host.first(name: host_name))
    else
      [ ]
    end
  end

  def auphonic_metadata(username="", password="")
    meta = {}
    
    if auphonic = data['auphonic']
      auphonic.each do |audio_format, auphonic_uuid|
        uri = URI.parse("https://auphonic.com/api/production/#{auphonic_uuid}.json")

        @http=Net::HTTP.new(uri.host, 443)
        @http.use_ssl = true

        @http.start do |http|
          req = Net::HTTP::Get.new(uri.path)
          req.basic_auth username, password
          response = http.request(req)
          parsed = JSON.parse(response.body)
          cur_metadata = {
            length:  parsed["data"]["length_timestring"]
          }

          meta[audio_format.to_sym] = cur_metadata
        end
      end
    end

    meta
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
