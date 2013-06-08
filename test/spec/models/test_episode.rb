# encoding: utf-8

require_relative '../helper'

describe Episode do

  it 'can set the content' do
    document = mock_document(content: 'Some content', data: { 'name' => 'epi' })
    episode = Episode.new(document)
    episode.content.must_equal('Some content')
  end

  it 'can set the teaser' do
    content = "!!!\nThis is the teaser\n!!!\nThis is the content"

    document = mock_document(content: content, data: { 'name' => 'epi' })
    episode = Episode.new(document)
    episode.content.must_equal('This is the content')
    episode.teaser.must_equal('This is the teaser')
  end

  it 'has an empty teaser when not available' do
    document = mock_document(content: '', data: { 'foo' => 'bar' })
    episode = Episode.new(document)
    episode.content.must_equal('')
    episode.teaser.must_equal('')
  end

  describe '#date' do

    it 'can parse the set date' do
      document = mock_document(content: '', data: { 'date' => '24.12.2012' })
      episode = Episode.new(document)
      episode.date.must_be_instance_of Date
      episode.date.must_equal Date.new(2012, 12, 24)
    end

  end

  describe '#status' do
  end

  describe '#hosts' do

    it 'returns an empty array when no hosts are available' do
      document = mock_document(content: '', data: { })
      hosts = Episode.new(document).hosts
      hosts.must_be_kind_of(Enumerable)
      hosts.must_be_empty
    end

    it 'can reference a single host with attribute host' do
      document = mock_document(content: '', data: { 'host' => 'asdf' })
      host = Host.new(stub(content: '', data: { 'name' => 'asdf' }))
      Host.expects(:first).with(name: 'asdf').returns(host)

      hosts = Episode.new(document).hosts
      hosts.must_be_kind_of(Enumerable)
      hosts.size.must_equal(1)
      hosts.first.must_equal(host)
    end

    it 'can reference a single host with attribute hosts' do
      document = mock_document(content: '', data: { 'hosts' => 'hjkl' })
      host = Host.new(stub(content: '', data: { 'name' => 'hjkl' }))
      Host.expects(:first).with(name: 'hjkl').returns(host)

      hosts = Episode.new(document).hosts
      hosts.must_be_kind_of(Enumerable)
      hosts.size.must_equal(1)
      hosts.must_equal([host])
    end

    it 'can reference a single host with array attribute hosts' do
      document = mock_document(content: '', data: { 'hosts' => ['huh'] })
      host = Host.new(stub(content: '', data: { 'name' => 'huh' }))
      Host.expects(:first).with(name: 'huh').returns(host)

      hosts = Episode.new(document).hosts
      hosts.must_be_kind_of(Enumerable)
      hosts.size.must_equal 1
      hosts.must_equal([host])
    end

    it 'can reference multiple hosts with array attribute hosts' do
      document = mock_document(content: '', data: { 'hosts' => ['asdf', 'huh'] })
      host1 = Host.new(stub(content: '', data: { 'name' => 'huh' }))
      host2 = Host.new(stub(content: '', data: { 'name' => 'asdf' }))
      Host.expects(:first).with(name: 'huh').returns(host1)
      Host.expects(:first).with(name: 'asdf').returns(host2)

      hosts = Episode.new(document).hosts
      hosts.must_be_kind_of(Enumerable)
      hosts.size.must_equal(2)
      hosts.must_include(host1)
      hosts.must_include(host2)
    end

    it 'only references valid hosts' do
      document = mock_document(
        content: '', data: { 'hosts' => ['asdf', 'huh', 'does_not_exist'] }
      )
      host1 = Host.new(stub(content: '', data: { 'name' => 'huh' }))
      host2 = Host.new(stub(content: '', data: { 'name' => 'asdf' }))
      Host.expects(:first).with(name: 'huh').returns(host1)
      Host.expects(:first).with(name: 'asdf').returns(host2)
      Host.expects(:first).with(name: 'does_not_exist').returns(nil)

      hosts = Episode.new(document).hosts
      hosts.must_be_kind_of(Enumerable)
      hosts.size.must_equal(2)
      hosts.must_include(host1)
      hosts.must_include(host2)
    end

  end

end
