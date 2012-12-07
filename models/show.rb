# encoding: utf-8

class Show < Model

  def initialize(options = {})
    super(options)
  end

  def default_template
    :shows
  end

  def episodes
    Episode.find(show: @meta_data["name"])
  end

end
