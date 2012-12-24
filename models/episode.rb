# encoding: utf-8

require 'date'

class Episode < Model

  attr_reader :teaser

  attribute :title
  attribute :status
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
    Date.parse(@data["date"])
  end

  def validate
    assert_present :date
    assert_present :status
  end

  def hosts
    if host_names = @data["hosts"]
      if host_names.respond_to?(:map)
        host_names.map do |host|
          Host.first(:name => host)
        end
      else
        Array(Host.first(:name => host_names))
      end
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
