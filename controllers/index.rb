# encoding: utf-8

class Podding < Sinatra::Base

  get "/page/:page" do |page|
    @page_num = page.to_i
    redirect to("/") if @page_num == 1
    all_episodes = Episode.sorted.reverse

    @paginated = true
    @page_max = all_episodes.count / settings.episodes_per_page
    @published_episodes = all_episodes.paginate(:page => @page_num, :per_page => settings.episodes_per_page)

    pass if @page_num > @page_max

    slim :index
  end

  get "/" do
    all_episodes = Episode.sorted.reverse

    @page_num = 1
    @page_max = (all_episodes.count / settings.episodes_per_page).to_f.ceil
    @paginated = @page_max > @page_num
    @published_episodes = all_episodes.paginate(:per_page => settings.episodes_per_page)

    slim :index
  end

end

