# encoding: utf-8

class Show < Model

  attribute :title
  attribute :cover_url
  attribute :author
  attribute :audioformats

  has_many :Episode, :episodes

  def audioformats
    if audioformat_names = data['audioformats']
      audioformat_names.map do |format|
        Audioformat.first(name: format)
      end
    end
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

