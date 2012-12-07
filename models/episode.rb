# encoding: utf-8

class Episode < Model

  def self.default_sort_order
    :date
  end

  def initialize(options = {})
    super(options)
  end

  def validate
    assert_present :date
  end

  def show
    Show.first(name: @meta_data["show"])
  end

  def hosts
    if host_names = @meta_data["hosts"]
      if host_names.respond_to?(:map)
        host_names.map do |host|
          Host.first(name: host)
        end
      else
        Array(Host.first(name: host_names))
      end
    else
      [ ]
    end
  end

end
