# encoding: utf-8

class MemoryStorage

  def initialize(namespace)
    @namespace = namespace
  end

  def all
    storage
  end

  def save(name, model_data)
    storage[name] = model_data unless storage.has_key?(name)

    true
  end

  private

  def self.storage
    @data ||= { }
  end

  def storage
    self.class.storage[@namespace] ||= { }
  end

end

