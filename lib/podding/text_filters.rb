# encoding: utf-8

class TextFilterEngine

  class << self

    def filters
      instance.filters
    end

    def register_filter(filter)
      instance.filters << filter
    end

    def unregister_filter(filter)
      instance.filters.delete(filter)
    end

    private
      def instance
        @instance ||= TextFilterEngine.new
      end

  end

  # TextFilterEngine instance

  def filters
    @filters ||= []
  end

end

class TextFilter

  def self.defaults(defaults = {})
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

  # Filters are executed like this: text -> markdown -> html
  def self.expects(format = :markdown)
    if format == :text
      self.priority -20
    elsif format == :markdown
      self.priority -10
    elsif format == :html
      self.priority 10
    end
  end

  # Instances

  # Overwrite the defaults with settings, if present
  def initialize(settings = {})
    @settings = self.class.defaults.merge(settings)
  end

end