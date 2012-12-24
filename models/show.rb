# encoding: utf-8

class Show < Model

  attribute :title
  attribute :cover_url
  attribute :author

  has_many :episodes, :Episode

  def initialize(options = {})
    super(options)
  end

  def live_episodes
    Episode.find(show: @data["name"], status: "live")
  end

  def published_episodes
    Episode.find(show: @data["name"], status: "published")
  end

  def planned_episodes
    Episode.find(show: @data["name"], status: "planned")
  end

end
