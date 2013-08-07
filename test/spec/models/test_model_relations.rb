# encoding: utf-8

require_relative '../helper'

class ReferenceModel < Model
  attribute :test

  belongs_to :OtherReferenceModel, :other_reference_model
end

class OtherReferenceModel < Model
  has_many :ReferenceModel, :reference_models, :other_reference_model
end

describe Model do

  before do
    doc1 = OpenStruct.new(
      :data => {
        'name' => 'test1',
        'test' => 'Hello World',
        'other_reference_model' => 'test2'
      },
      :content => 'Content'
    )

    doc2 = OpenStruct.new(
      :data => {
        'name' => 'test2',
        'test' => 'Hello World',
        'reference_model' => 'test1'
      },
      :content => 'Content'
    )

    @reference_model = ReferenceModel.new(doc1)
    @other_reference_model = OtherReferenceModel.new(doc2)
  end

  describe '#belongs_to' do

    it 'should have a method referencing the related model' do
      @reference_model.must_respond_to(:other_reference_model)
    end

    it 'should generate the right first() call' do
      OtherReferenceModel.expects(:first).with(name: 'test2').returns(@other_reference_model)
      @reference_model.other_reference_model.must_equal(@other_reference_model)
    end

  end

  describe '#has_many' do

    it 'should have a method referencing related models' do
      @other_reference_model.must_respond_to(:reference_models)
    end

    it 'should generate the right find()' do
      ReferenceModel.expects(:find).with(other_reference_model: 'test2').returns([ @reference_model ])
      @other_reference_model.reference_models.must_equal([ @reference_model ])
    end

  end

end

