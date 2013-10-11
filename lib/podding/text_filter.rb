# encoding: utf-8

class TextFilter

  def self.defaults(defaults = { })
    @defaults ||= defaults
  end

  # Priority defines the order in which the filters are applied
  def self.priority(priority = nil)
    @priority ||= priority
    @priority || 0
  end

  def self.<=>(other)
    self.priority <=> other.priority
  end

  # Filters are executed in this order: text -> markdown -> html
  def self.needs(format = :markdown)
    prio = case format
           when :text then -20
           when :markdown then -10
           when :html then 10
           end

    self.priority(prio)
  end

  # Instances

  # Overwrite the defaults with settings, if present
  def initialize(settings = { })
    @settings = self.class.defaults.merge(settings)
  end

  def render(str)
    raise NotImplementedError, "#render has to be overridden in #{ self.class.name }"
  end

end

