module Finders

  def [](name)
    first(name: name)
  end

  def first(filters)
    find(filters).first
  end

  def find(filters)
    validate_filters(filters)

    all.select do |model|
      filters.all? do |param, value|
        model.data[param.to_s] == value
      end
    end
  end

  def find_match(filters)
    validate_filters(filters)

    all.select do |model|
      filters.all? do |param, value|
        data = model.data[param.to_s]

        if data
          result = case data
                   when Enumerable then data.select { |el| el.match(value) }
                   when String then data.match(value)
                   end

          result && result.size > 0
        end
      end
    end
  end

  private

  def validate_filters(filters)
    unless filters.kind_of?(Hash)
      raise ArgumentError, "You need to pass a hash with filters. " +
        "If you want to find elements by name, use #{ self }[name] instead."
    end
  end

end
