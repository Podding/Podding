# encoding: utf-8

class ShowController < Controller

  def initialize(show_name)
    @name = show_name
  end

  def render(episode_name = :all)
    "this would render #{episode_name} of show #{@name}"
  end

end
