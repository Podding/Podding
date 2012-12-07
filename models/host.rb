# encoding: utf-8

class Host < Model

  def initialize(options = {})
    super(options)
  end

  def default_template
    :hosts
  end

  def episodes
    Episode.find_match(hosts: @meta_data["name"])
  end

end
