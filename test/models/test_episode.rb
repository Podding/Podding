require_relative 'helper'

class EpisodeModelTest < MiniTest::Unit::TestCase

  def setup
    @episodes = Episode.all
  end

  def test_episode_amount
    assert_equal 5, @episodes.count
  end

  def test_episode_type
    assert @episodes.all? { |e| e.instance_of?(Episode) }
  end

  def test_episode_content
    assert @episodes.all? { |e| !e.content.empty? }
  end

  def test_episode_path
    assert @episodes.all? { |e| File.exist? e.path }
  end

  def test_find_by_show
    assert_equal 2, Episode.find(show: "foo").count
    assert_equal 2, Episode.find(show: "bar").count
  end

  def test_find_by_title
    assert_equal 1, Episode.find(title: "Derp Herp derp").count
    assert_equal 1, Episode.find(title: "Asdf").count
  end

  def test_find_by_status
    assert_equal 2, Episode.find(status: "unpublished").count
    assert_equal 3, Episode.find(status: "published").count
  end

end
