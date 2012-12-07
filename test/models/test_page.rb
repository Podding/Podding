
require_relative 'helper'

class PageModelTest < MiniTest::Unit::TestCase

  def setup
    @pages = Page.all
  end

  def test_scan_files
    files = Page.scan_files
    assert_equal 4, files.count
  end

  def test_page_amount
    assert_equal 4, @pages.count
  end

  def test_page_type
    assert @pages.all? { |s| s.instance_of?(Page) }
  end

  def test_page_path
    assert @pages.all? { |s| File.exist? s.path }
  end

  def test_validity
    assert @pages.all? { |p| p.valid? }
  end

  def test_find_page_by_name
    assert 1, Page.find(name: "page1").count
    assert 1, Page.find(name: "page2").count
  end

end
