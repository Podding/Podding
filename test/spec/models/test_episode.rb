# encoding: utf-8

require_relative '../helper'

describe Episode do

  before do
    content = <<-EOF
---
name: epi
date: 24.12.2012
---
!!!
This is the teaser
!!!
This is the content
    EOF

    @episode = Episode.new(raw_content: content)
  end

  it 'has a correct date' do
    @episode.date.must_be_instance_of Date
    @episode.date.must_equal Date.new(2012, 12, 24)
  end

  it 'sets the content' do
    @episode.content.must_equal "This is the content\n"
  end

  it 'sets the teaser' do
    @episode.teaser.must_equal 'This is the teaser'
  end

  it 'has an empty teaser when not available' do
    Episode.new(raw_content: 'content').teaser.must_equal ''
  end

end
