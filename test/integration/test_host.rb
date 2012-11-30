require_relative 'helper'

class HostTest < MiniTest::Unit::TestCase

  def test_hosts_response
    get '/hosts'
    assert last_response.ok?
  end

  def test_host_response
    get '/hosts/derp0'
    assert last_response.ok?
    get '/hosts/foo_bert'
    assert last_response.ok?
  end

  def test_template_rendering
    validate_meta_data("/hosts/derp0", {
      handle: "derp0",
      name: "Derp Inger",
      twitter_name: "doh",
      image_url: "http://placekitten.com/300/300"
    })

    validate_meta_data("/hosts/foo_bert", {
      handle: "foo_bert",
      name: "Foo bert",
      twitter_name: "durr",
      image_url: "http://placedog.com/400/400",
      quip: "huh!"
    })
  end

  def test_content_rendering
    get '/hosts'
    assert_match %r{<h1>Derpinger!</h1>}, last_response.body
    assert_match %r{<h2>FOO!</h2>}, last_response.body
  end

end

