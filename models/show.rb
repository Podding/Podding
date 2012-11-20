# encoding: utf-8

class ShowModel < Model

  class << self

    def all(options = {})
    end

    def find(options = {})
    end

  end

  def initialize(options = {})
    super(options)
  end

  def default_template
    :show
  end

end
