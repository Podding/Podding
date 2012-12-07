require_relative 'helper'

class EpisodeModelTest < MiniTest::Unit::TestCase

  def setup
    @episodes = Episode.all
  end

  def test_files_amount
    assert_equal 5, Episode.scan_files.count
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

  def test_validity
    assert @episodes.all? { |e| e.valid? }
  end

  def test_episode_sorting
    assert_equal @episodes.sort_by(&:date), @episodes
  end

  # Test find()

  def test_find_by_show
    assert_equal 1, Episode.find(show: "foo").count
    assert_equal 1, Episode.find(show: "bar").count
    assert_equal 2, Episode.find(show: "show1").count
    assert_equal 1, Episode.find(show: "show_2").count
  end

  def test_find_by_title
    assert_equal 1, Episode.find(title: "Derp Herp derp").count
    assert_equal 1, Episode.find(title: "Asdf").count
  end

  def test_find_by_status
    assert_equal 2, Episode.find(status: "unpublished").count
    assert_equal 3, Episode.find(status: "published").count
  end

  def test_find_match_by_host
    episodes = Episode.find_match(hosts: "derp0")
    assert_equal 3, episodes.count
    episodes = Episode.find_match(hosts: /derp[\d]?/)
    assert_equal 3, episodes.count
  end

  # Test relation to Host

  def test_hosts_count
    episode = Episode.first(title: "Derp Herp derp")
    assert_equal 2, episode.hosts.count
  end

  def test_hosts_type
    episode = Episode.first(title: "Derp Herp derp")
    assert episode.hosts.all? { |e| e.instance_of?(Host) }
  end

  def test_empty_hosts
    episode = Episode.first(title: "Trolololo")
    assert_equal [], episode.hosts
  end

  def test_non_array_host
    episode = Episode.first(title: "Asdf")
    assert episode.hosts.kind_of?(Enumerable)
    assert episode.hosts.all? { |e| e.instance_of?(Host) }
    assert_equal 1, episode.hosts.count
    assert_equal "derp0", episode.hosts.first.name
    assert_equal "Derp Inger", episode.hosts.first.full_name
  end

  # Test relation to Show

  def test_show_type
    episode = Episode.first(title: "Asdf")
    assert episode.show.instance_of?(Show)
    assert_equal episode.meta_data["show"], episode.show.name
  end

end
