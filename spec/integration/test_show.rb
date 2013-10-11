require_relative 'helper'

class ShowTest < MiniTest::Unit::TestCase

  def test_shows_response
    get '/shows'
    assert last_response.ok?
  end

  def test_show_response
    get '/shows/show1'
    assert last_response.ok?
    get '/shows/show_2'
    assert last_response.ok?
  end

  def test_show_template
    get '/shows'
    assert_match %r{<h1>Shows default template</h1>}, last_response.body
    get '/shows/show1'
    assert_match %r{<h1>Show single template</h1>}, last_response.body
    get '/shows/show_2'
    assert_match %r{<h1>Shows super custom template</h1>}, last_response.body
  end


  def test_template_rendering
    validate_meta_data("/shows/show1", {
      name: "show1",
      title: "My super show 1"
    })

    validate_meta_data("/shows/show_2", {
      template: "custom_shows_template",
      name: "show_2",
      title: "My super show 2"
    })
  end

  def test_content_rendering
    get '/shows'
    assert_match %r{<h1>Show 1</h1>}, last_response.body
    assert_match %r{<h1>Show 2</h1>}, last_response.body
    assert_match %r{This is a slightly different show about}, last_response.body
    assert_match %r{This is a show about stuff by people}, last_response.body
  end

end

