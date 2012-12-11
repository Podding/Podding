# encoding: utf-8

module Utils

  def self.class_lookup(context, klass)
    case klass
    when Symbol then context.const_get(klass)
    else klass
    end
  end

end
