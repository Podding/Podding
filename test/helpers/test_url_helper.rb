# encoding: utf-8

require_relative 'helper'

class CustomModel
  def name
    "fufufu"
  end
end

class URLHelperTest < MiniTest::Unit::TestCase
  # Include tested module
  include URLs

  def test_episode_urls
    episode = Episode.first(title: "Trolololo")
    assert_equal "/shows/#{ episode.show.name }/#{ episode.name }", url_for(episode)
  end

  def test_show_urls
    show =  Show.first(name: "show1")
    assert_equal "/shows/#{ show.name }", url_for(show)
  end

  def test_page_urls
    page =  Page.first(name: "page1")
    assert_equal "/pages/#{ page.name }", url_for(page)
  end

  def test_custom_model_urls
    model = CustomModel.new
    assert_equal "/custommodels/#{ model.name }", url_for(model)
  end

  def test_twitter_url
    host = Host.first(name: "derp0")
    assert_equal "https://twitter.com/#{ host.twitter_name }", twitter_url(host)
  end

  def test_flattr_url
    host = Host.first(name: "derp0")
    assert_equal "https://flattr.com/profile/#{ host.twitter_name }", flattr_url(host)
  end

end
