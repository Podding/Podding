# encoding: utf-8

module Utils

  def self.class_lookup(context, klass)
    case klass
    when Symbol then context.const_get(klass)
    else klass
    end
  end

  def self.pluralize(str)
    if str.end_with?('y')
      str.gsub(/y$/, 'ies')
    else
      str + 's'
    end
  end

end
