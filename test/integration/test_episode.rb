require_relative 'helper'

class EpisodeTest < MiniTest::Unit::TestCase

  def test_episode_response
    get '/shows/show_2/trololololo'
    assert last_response.ok?
    get '/shows/show1/asdf'
    assert last_response.ok?
  end

  def test_template_rendering
    validate_meta_data("/shows/show1/asdf", {
      name: "asdf",
      title: "Asdf",
      show: "show1",
      date: "15.8.2012",
      status: "published"
    })
  end

  def test_content_rendering
    get '/shows/show1/asdf'
    assert_match %r{<h1>Hey Ho</h1>}, last_response.body
    assert_match %r{<p>This is another test</p>}, last_response.body
  end

end

