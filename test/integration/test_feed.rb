require_relative 'helper'

class IndexTest < MiniTest::Unit::TestCase

  def test_response_feed_all
    get '/feed/mp3/feed.xml'
    assert last_response.ok?
  end

  def test_response_feed_single_show
    get '/feed/show1/mp3/feed.xml'
    assert last_response.ok?
  end

  def test_valid_feed_all
    get '/feed/mp3/feed.xml'
    feed = Nokogiri::XML(last_response.body)
    assert_equal 3, feed.css("feed entry").count
    assert_equal 3, feed.css("feed entry link[href $='mp3']").count
  end

  def test_valid_feed_show
    get '/feed/show1/mp3/feed.xml'
    feed = Nokogiri::XML(last_response.body)
    assert_equal 2, feed.css("feed entry").count
    asser_equal 2, feed.css("feed entry link[href $='mp3']").count
  end
end
