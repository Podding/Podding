# encoding: utf-8

require_relative '../helper'

class TestModel < Model
  attribute :test
end

class OtherModel < TestModel
  attribute :asdf
end

describe Model do

  describe 'attribute' do

    let(:test_model) do
      TestModel.new(mock_with_attributes(
        content: 'foo',
        data: { 'name' => 'a', 'test' => 'b' }
      ))
    end

    it 'should have valid getter methods' do
      test_model.must_respond_to(:name)
      test_model.must_respond_to(:test)
      test_model.name.must_equal('a')
      test_model.test.must_equal('b')
    end

  end

  describe 'attributes' do

    it 'should return the correct attributes' do
      TestModel.attributes.must_equal([ :name, :test ])
    end

    it 'should return the correct inherited attributes' do
      OtherModel.attributes.must_equal([ :name, :test, :asdf ])
    end

  end

  describe 'has_attribute?' do
    # TODO write tests and implement
  end

  describe '#initialize' do

    it 'should call the right document methods' do
      data = { 'foo' => 'bar' }
      document = mock_with_attributes(content: 'content', data: data)
      model = Model.new(document)
      model.content.must_equal('content')
      model.data.must_equal(data)
    end

  end

  describe '#content' do

    it 'can set the content' do
      document = mock_with_attributes(
        content: 'Some content',
        data: { 'name' => 'epi' }
      )
      episode = Model.new(document)
      episode.content.must_equal('Some content')
    end

  end

  describe '#valid?' do

    it 'should be invalid without a name' do
      document = stub(content: 'CONTENT', data: { 'noname' => 'a' })
      Model.new(document).valid?.must_equal(false)
    end

    it 'is valid with a name' do
      document = stub(content: 'CONTENT', data: { 'name' => 'Peter' })
      Model.new(document).valid?.must_equal(true)
    end

  end

end

