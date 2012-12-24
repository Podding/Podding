# encoding: utf-8

require_relative '../helper'

class ReferenceModel < Model
  attribute :test

  belongs_to :other_reference_model, :OtherReferenceModel
end

class OtherReferenceModel < Model
  has_many :reference_models, :ReferenceModel, :other_reference_model
end

describe Model do

  before do
    content = <<-EOF
---
name: test1
test: "Hello World"
other_reference_model: test2
---
Content
    EOF

    other_content = <<-EOF
---
name: test2
reference_model: test1
---
Moar content

EOF
    @reference_model = ReferenceModel.new(raw_content: content)
    @reference_model.save
    @other_reference_model = OtherReferenceModel.new(raw_content: other_content)
    @other_reference_model.save
  end

  describe '#attribute' do

    it 'should have valid getter methods' do
      @reference_model.must_respond_to :name
      @reference_model.must_respond_to :test
      @reference_model.name.must_equal 'test1'
      @reference_model.test.must_equal 'Hello World'
    end

    it 'should have an attribute array' do
      @reference_model.class.attributes.must_equal [ :test ]
      @reference_model.attributes.must_equal [ :test ]
    end

  end

  describe '#belongs_to' do

    it 'should have a method referencing the related model' do
      @reference_model.must_respond_to :other_reference_model
    end

    it 'should reference the right model' do
      @reference_model.other_reference_model.must_equal @other_reference_model
    end

  end

  describe '#has_many' do

    it 'should have a method referencing related models' do
      @other_reference_model.must_respond_to :reference_models
    end

    it 'should reference the right models' do
      @other_reference_model.reference_models.must_equal [ @reference_model ]
    end

  end

end

