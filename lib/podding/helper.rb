module Helper

  def self.defined_helpers
    @defined_helpers ||= []
  end

  def self.included(base)
    self.defined_helpers << base
  end

end
