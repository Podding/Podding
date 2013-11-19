# encoding: utf-8

class Show < Mlk::Model

  attribute :title
  attribute :cover_url
  attribute :audioformats

  has_many :Episode, :episodes

  # TODO: Use better default mechanism
  def author
    @data["author"] ? @data["author"] : Settings.author
  end

  # TODO: Use better default mechanism
  def description
    @data["description"] ? @data["description"] : Settings.description
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

