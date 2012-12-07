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

  def published_episodes
    Episode.find(show: @meta_data["name"], status: "published")
  end

  def planned_episodes
    Episode.find(show: @meta_data["name"], status: "planned")
  end

end
