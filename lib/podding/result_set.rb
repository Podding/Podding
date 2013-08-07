# encoding: utf-8


class ResultSet

  attr_reader :results

  def initialize(results)
    validate_results(results)
    @results = results

    # Make sure it's immutable
    @results.freeze
  end

  def all
    ResultSet.new(@results)
  end

  def each(&block)
    @results.each(&block)
  end

  def include?(result)
    @results.include?(result)
  end

  def ==(other)
    other.results == self.results
  end

  def empty?
    @results.empty?
  end

  def size
    @results.size
  end

  alias_method :length, :size

  def first(filters = {})
    find(filters).results.first
  end

  def find(filters)
    validate_filters(filters)

    results = @results.select do |result|
      filters.all? do |param, value|
        if value == :exists
          result.data.has_key?(param.to_s)
        else
          result.data[param.to_s] == value
        end
      end
    end

    ResultSet.new(results)
  end

  def find_match(filters)
    validate_filters(filters)

    results = @results.select do |result|
      filters.all? do |param, value|
        data = result.data[param.to_s]

        if data
          match = case data
                  when Enumerable then data.select { |el| el.match(value) }
                  when String then data.match(value)
                  end

          match && match.size > 0
        end
      end
    end

    ResultSet.new(results)
  end

  def group_by(attribute)
    grouped = @results.each_with_object({ }) do |result, acc|
      key = result.send(attribute)
      acc[key] ||= []
      acc[key] << result
    end
    grouped.default = [ ]

    grouped
  end

  def sort_by(attribute)
    attribute = attribute.to_sym
    ResultSet.new(@results.sort_by(&attribute))
  end

  private

  def validate_results(res)
    unless res.kind_of?(Enumerable)
      raise ArgumentError, 'You need to pass an instance of Enumerable!'
    end
  end

  def validate_filters(filters)
    unless filters.kind_of?(Hash)
      raise ArgumentError, 'You need to pass a hash with filters.'
    end
  end

end
