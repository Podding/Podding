# encoding: utf-8

require_relative '../helper'

class TestModel < Model
end

describe Model do

  # todo test metaprogramming

  describe '#initialize' do

    it 'should call the right document methods' do
      data = { 'foo' => 'bar' }
      document = mock_document(content: 'content', data: data)
      model = Model.new(document)
      model.content.must_equal('content')
      model.data.must_equal(data)
    end

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

