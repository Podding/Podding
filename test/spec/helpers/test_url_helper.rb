# encoding: utf-8

require_relative '../helper'


describe URLs do
  include URLs

  class Content; end

  it 'should generate content URLs' do
    content = Content.new

    Content.expects(:name).returns("Content")
    content.expects(:name).returns('my_content')

    url_for(content).must_equal('/contents/my_content')
  end

  it 'should generate correct episode URLs' do
    episode = mock
    episode.expects(:class).returns(Episode)
    episode.expects(:name).returns('my_episode')

    show = mock
    show.expects(:name).returns('my_show')
    episode.expects(:show).returns(show)

    url_for(episode).must_equal('/shows/my_show/my_episode')
  end

  it 'should generate correct twitter URLs' do
    host = mock
    host.expects(:twitter_name).returns('my_twitter')
    twitter_url(host).must_equal('https://twitter.com/my_twitter')
  end

  it 'should generate correct flattr URLSs' do
    host = mock
    host.expects(:flattr_name).returns('my_flattr')
    flattr_url(host).must_equal('https://flattr.com/profile/my_flattr')
  end

end


