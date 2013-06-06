# encoding: utf-8

module Navigation
  include Helper

  def all_shows
    Show.all
  end

  def all_hosts
    Host.all
  end

end
