require_relative 'helper'

class HostModelTest < MiniTest::Unit::TestCase
  def setup
    @hosts = Host.all
  end

  def test_host_amount
    assert_equal 2, @hosts.count
  end

  def test_host_type
    assert @hosts.all? { |h| h.instance_of?(Host) }
  end

  def test_host_content
    assert @hosts.all? { |h| !h.content.empty? }
  end

  def test_host_path
    assert @hosts.all? { |h| File.exist? h.path }
  end

  # Test find()

  def test_find_host_by_name
    assert_equal 1, Host.find(name: "derp0").count
    assert_equal 1, Host.find(name: "foo_bert").count
  end

  def test_find_host_by_full_name
    assert_equal 1, Host.find(full_name: "Derp Inger").count
    assert_equal 1, Host.find(full_name: "Foo bert").count
  end

  def test_find_host_by_twitter_name
    assert_equal 1, Host.find(twitter_name: "doh").count
    assert_equal 1, Host.find(twitter_name: "durr").count
  end

  def test_find_host_by_whishlist_url
    assert_equal 1, Host.find(wishlist_url: "http://derp.com").count
  end

  def test_find_host_by_image_url
    assert_equal 1, Host.find(image_url: "http://placedog.com/400/400").count
    assert_equal 1, Host.find(image_url: "http://placekitten.com/300/300").count
  end

  def test_find_host_by_quip
    assert_equal 1, Host.find(quip: "woah!").count
    assert_equal 1, Host.find(quip: "huh!").count
  end

  # Test relation to Episode

  def test_episodes_count
    host = Host.first(name: "derp0")
    assert_equal 3, host.episodes.count
    host = Host.first(name: "foo_bert")
    assert_equal 2, host.episodes.count
  end

end
