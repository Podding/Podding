# encoding: utf-8

class Show < Model

  attribute :title
  attribute :cover_url
  attribute :author
  attribute :audioformats

  has_many :episodes, :Episode

  def audioformats
    if audioformat_names = data['audioformats']
      if audioformat_names.is_a?(Array)
        audioformats = Array.new
        audioformat_names.each do |format|
          audioformats << Audioformat.first(name: format)
        end
        return audioformats
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
