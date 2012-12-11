# encoding: utf-8

class Host < Model

  has_many :episodes, :Episode, :hosts

  def initialize(options = {})
    super(options)
  end

  def default_template
    :hosts
  end

end
