# encoding: utf-8

class MemoryStorage

  def initialize(namespace)
    @namespace = namespace
  end

  def all
    storage
  end

  def save(model_data)
    storage << model_data unless storage.include?(model_data)
  end

  private

  def self.storage
    @data ||= { }
  end

  def storage
    self.class.storage[@namespace] ||= [ ]
  end

end

