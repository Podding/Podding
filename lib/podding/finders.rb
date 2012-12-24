module Finders

  def first(options = {})
    find(options).first
  end

  def find(options = {})
    all.select do |model|
      options.all? do |param, value|
        model.data[param.to_s] == value
      end
    end
  end

  def find_match(options = {})
    all.select do |model|
      options.all? do |param, value|
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

end
