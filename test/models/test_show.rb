require_relative 'helper'

class ShowModelTest < MiniTest::Unit::TestCase
  def setup
    @shows = Show.all
  end

  def test_files_amount
    assert_equal 2, Show.scan_files.count
  end

  def test_show_amount
    assert_equal 2, @shows.count
  end

  def test_show_type
    assert @shows.all? { |s| s.instance_of?(Show) }
  end

  def test_show_content
    assert @shows.all? { |s| !s.content.empty? }
  end

  def test_show_path
    assert @shows.all? { |s| File.exist? s.path }
  end

  def test_validity
    assert @shows.all? { |s| s.valid? }
  end

  # Test find()

  def test_find_show_by_name
    assert 1, Show.find(name: "show1").count
    assert 1, Show.find(name: "show_2").count
  end

  def test_find_show_by_title
    assert 1, Show.find(title: "My super show 1").count
    assert 1, Show.find(title: "My super show 2").count
  end

  def test_find_show_by_template
    assert 1, Show.find(template: "custom_shows_template").count
  end

  # Test relation to Episode

  def test_episodes_count
    show = Show.first(name: "show1")
    assert_equal 2, show.episodes.count
    show = Show.first(name: "show_2")
    assert_equal 1, show.episodes.count
  end

  def test_episodes_relation
    show = Show.first(name: "show1")
    show.episodes.each { |e| assert_equal show, e.show }
  end

end
