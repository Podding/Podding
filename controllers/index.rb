# encoding: utf-8

class Podding < Sinatra::Base

  get "/page/:page" do |page|
    @page_num = page.to_i
    redirect to("/") if @page_num == 1

    episodes = Episode.all
    @live_episodes = [] # higher pages don't need these
    @published_episodes = [] # higher pages don't need these
    @planned_episodes = []
    for episode in episodes
      if episode.status == "published"
        @published_episodes << episode
      end
    end

    @paginated = true
    @page_max = (( @published_episodes.length / settings.episodes_per_page ).to_f).ceil
    @published_episodes = @published_episodes.slice!((@page_num-1)*settings.episodes_per_page,settings.episodes_per_page)

    pass if @page_num > @page_max

    slim :index
  end

  get "/" do
    episodes = Episode.all
    @live_episodes = []
    @published_episodes = []
    @planned_episodes = []
    for episode in episodes
      if episode.status == "published"
        @published_episodes << episode
      elsif episode.status == "live"
        @live_episodes << episode
      else
        @planned_episodes << episode
      end
    end


    @paginated = true if @published_episodes.length > settings.episodes_per_page
    @page_num = 1
    @page_max = (( @published_episodes.length / settings.episodes_per_page ).to_f).ceil
    @published_episodes = @published_episodes.slice!(0,settings.episodes_per_page)
    slim :index
  end



end

