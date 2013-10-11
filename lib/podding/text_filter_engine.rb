# encoding: utf-8

require 'singleton'
require 'set'

class TextFilterEngineBase

  def initialize
    @filters = ::Set.new
  end

  def register_filter(filter)
    @filters << filter
  end

  def unregister_filter(filter)
    @filters.delete(filter)
  end

  def render(content, options = { })
    content = content.to_str.clone

    self.filters.inject(content) do |memo, filter|
      filter.new(options).render(memo)
    end
  end

  def filters
    @filters.to_a.sort
  end

end

class TextFilterEngine < TextFilterEngineBase
  include Singleton
  extend SingleForwardable

  def_delegators :instance, :register_filter, :unregister_filter, :filters
end

