# encoding: utf-8

class Page < Model

  attribute :title
  attribute :icon
  attribute :label
  attribute :quip

  def initialize(options)
    super(options)
  end

end
