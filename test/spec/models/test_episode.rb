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

  it 'can be created with empty content' do
    episode = Episode.new(raw_content: '')
    episode.content.must_be_empty
    episode.teaser.must_be_empty
    episode.hosts.must_be_empty
  end

  it 'sets the content' do
    @episode.content.must_equal 'This is the content'
  end

  it 'sets the teaser' do
    @episode.teaser.must_equal 'This is the teaser'
  end

  it 'has an empty teaser when not available' do
    Episode.new(raw_content: 'content').teaser.must_equal ''
  end

  describe '#date' do

    it 'can parse the set date' do
      @episode.date.must_be_instance_of Date
      @episode.date.must_equal Date.new(2012, 12, 24)
    end

  end

  describe '#hosts' do

    before do
      @asdf = Host.new(raw_content: "---\n name: asdf \n---")
      @asdf.save
      @hjkl = Host.new(raw_content: "---\n name: hjkl \n---")
      @hjkl.save
      @huh = Host.new(raw_content: "---\n name: huh \n---")
      @huh.save
    end

    it 'returns an empty array when no hosts are available' do
      hosts = @episode.hosts
      hosts.must_be_kind_of(Enumerable)
      hosts.must_be_empty
    end

    it 'can reference a single host with attribute host' do
      hosts = Episode.new(raw_content: "---\n host: asdf \n---").hosts
      hosts.must_be_kind_of(Enumerable)
      hosts.size.must_equal 1
    end

    it 'can reference a single host with attribute hosts' do
      hosts = Episode.new(raw_content: "---\n hosts: hjkl \n---").hosts
      hosts.must_be_kind_of(Enumerable)
      hosts.size.must_equal 1
      hosts.must_include @hjkl
    end

    it 'can reference a single host with array attribute hosts' do
      hosts = Episode.new(raw_content: "---\n hosts: [ huh ] \n---").hosts
      hosts.must_be_kind_of(Enumerable)
      hosts.size.must_equal 1
      hosts.must_include @huh
    end

    it 'can reference multiple hosts with array attribute hosts' do
      hosts = Episode.new(raw_content: "---\n hosts: [ asdf, hjkl, huh ] \n---").hosts
      hosts.must_be_kind_of(Enumerable)
      hosts.size.must_equal 3
      hosts.must_include @asdf
      hosts.must_include @hjkl
      hosts.must_include @huh
    end

    it 'only references valid hosts' do
      hosts = Episode.new(raw_content: "---\n hosts: [ asdf, hjkl, non_existing ] \n---").hosts
      hosts.must_be_kind_of(Enumerable)
      hosts.size.must_equal 2
    end

  end

end
