# encoding: utf-8

class Show < Model

  attribute :title
  attribute :cover_url

  has_many :episodes, :Episode

  def initialize(options = {})
    super(options)
  end

  def default_template
    :shows
  end

  def published_episodes
    Episode.find(show: @meta_data["name"], status: "published")
  end

  def planned_episodes
    Episode.find(show: @meta_data["name"], status: "planned")
  end

end
