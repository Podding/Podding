require_relative 'helper'

class PageTest < MiniTest::Unit::TestCase


  def test_response
    get '/pages/page1'
    assert last_response.ok?
    get '/pages/page2'
    assert last_response.ok?
  end

  def test_markdown_rendering
    get '/pages/page1'
    assert_match %r{<h1>Foo</h1>}, last_response.body
    assert_match %r{I was wetter than an English summer}, last_response.body
    assert_match %r{<h3>Our Story</h3>}, last_response.body
  end

  def test_default_template_rendering
    get '/pages/page1'
    assert_match %r{<h1>Default Template</h1>}, last_response.body

    validate_meta_data('/pages/page1', {
      foo: "bar",
      hurr: "durr",
      baz: "lol"
    })
  end

  def test_custom_template_rendering
    get '/pages/page2'
    assert_match %r{<h1>Super Custom Template</h1>}, last_response.body

    validate_meta_data('/pages/page2', {
      template: "custom_page_template",
      asdf: "hkll",
      so: "no"
    })
  end

end

