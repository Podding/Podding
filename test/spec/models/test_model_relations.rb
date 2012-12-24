# encoding: utf-8

require_relative '../helper'


class TestModel < Model
  attribute :test
end

describe Model do

  before do
    content = <<-EOF
---
test: "Hello World"
---
Content
    EOF
    @test_model = TestModel.new(raw_content: content)
  end

  describe '#attribute' do

    it 'should have a getter method' do
      @test_model.must_respond_to :test
      @test_model.test.must_equal 'Hello World'
    end

    it 'should have an attribute array' do
      @test_model.class.attributes.must_equal [ :test ]
      @test_model.attributes.must_equal [ :test ]
    end


  end

end

