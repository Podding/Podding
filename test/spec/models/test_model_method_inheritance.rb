# encoding: utf-8

require_relative '../helper'

class ChildModel < Model
  belongs_to :ParentModel, :parent_model
  belongs_to :AnotherParentModel, :another_parent_model
  inherits_from :parent_model, :test_method, :test_method_nil, :test_attribute, :test_attribute_nil, :grandparent_test_method_nil, :grandparent_test_attribute_nil
  inherits_from :another_parent_model, :another_test_method, :another_test_method_nil, :another_test_attribute, :another_test_attribute_nil

  attribute :test_attribute
  attribute :test_attribute_nil
  attribute :another_test_attribute
  attribute :another_test_attribute_nil
  attribute :grandparent_test_attribute_nil

  def test_method_nil
    nil
  end

  def test_method
    "child"
  end

  def another_test_method_nil
    nil
  end

  def another_test_method
    "child"
  end

  def grandparent_test_method_nil
    nil
  end
end

class ParentModel < Model
  belongs_to :GrandParentModel, :grandparent_model
  
  inherits_from :grandparent_model, :grandparent_test_method_nil, :grandparent_test_attribute_nil

  attribute :test_attribute
  attribute :test_attribute_nil
  attribute :grandparent_test_attribute_nil

  def test_method_nil
    "parent!"
  end

  def test_method
    "parent"
  end

  def grandparent_test_method_nil
    nil
  end
end

class AnotherParentModel < Model
  attribute :another_test_attribute
  attribute :another_test_attribute_nil

  def another_test_method_nil
    "another_parent!"
  end

  def another_test_method
    "another_parent"
  end
end

class GrandParentModel < Model
  attribute :grandparent_test_attribute_nil

  def grandparent_test_method_nil
    "grandparent"
  end
end

describe Model do

  before do
    child_doc = OpenStruct.new(
      :data => {
        'name' => 'child',
        'test_attribute' => 'child attribute',
        'another_test_attribute' => 'child attribute',
        # omitted test_attribute_nil
        'parent_model' => 'parent',
        'another_parent_model' => 'another_parent'
      },
      :content => 'Content'
    )

    parent_doc = OpenStruct.new(
      :data => {
        'name' => 'parent',
        'test_attribute' => 'parent attribute',
        'test_attribute_nil' => 'parent nil attribute',
        'child_model' => 'child',
        'grandparent_model' => 'grandparent'
      },
      :content => 'Content'
    )

    another_parent_doc = OpenStruct.new(
      :data => {
        'name' => 'another_parent',
        'another_test_attribute' => 'parent attribute',
        'another_test_attribute_nil' => 'parent nil attribute',
        'child_model' => 'child'
      },
      :content => 'Content'
    )

    grandparent_doc = OpenStruct.new(
      :data => {
        'name' => 'grandparent',
        'grandparent_test_attribute_nil' => 'grandparent nil attribute',
        'parent_child_model' => 'parent'
      },
      :content => 'Content'
    )

    @child_model = ChildModel.new(child_doc)
    @parent_model = ParentModel.new(parent_doc)
    @another_parent_model = AnotherParentModel.new(another_parent_doc)
    @grandparent_model = GrandParentModel.new(grandparent_doc)
  end

  describe '#inherits_from' do

    it 'should not inherit methods that do not return nil' do
      @child_model.test_method.must_equal( "child" )
    end

    it 'should inherit methods that return nil' do
      ParentModel.expects(:first).with(name: 'parent').returns(@parent_model)
      @child_model.test_method_nil.must_equal( @parent_model.test_method_nil )
    end

    it 'should not inherit attributes that are not nil' do
      @child_model.test_attribute.must_equal( "child attribute" )
    end

    it 'should inherit attributes that are nil' do
      ParentModel.expects(:first).with(name: 'parent').returns(@parent_model)
      @child_model.test_attribute_nil.must_equal( @parent_model.test_attribute_nil )
    end

    # does it also work for multiple models?

    it 'should not inherit methods that do not return nil from another model' do
      @child_model.another_test_method.must_equal( "child" )
    end

    it 'should inherit methods that return nil from another model' do
      AnotherParentModel.expects(:first).with(name: 'another_parent').returns(@another_parent_model)
      @child_model.another_test_method_nil.must_equal( @another_parent_model.another_test_method_nil )
    end

    it 'should not inherit attributes that are not nil from another model' do
      @child_model.another_test_attribute.must_equal( "child attribute" )
    end

    it 'should inherit attributes that are nil from another model' do
      AnotherParentModel.expects(:first).with(name: 'another_parent').returns(@another_parent_model)
      @child_model.another_test_attribute_nil.must_equal( @another_parent_model.another_test_attribute_nil )
    end

    # does it chain?

    it 'should inherit methods that return nil from another model up the chain' do
      ParentModel.expects(:first).with(name: 'parent').returns(@parent_model)
      GrandParentModel.expects(:first).with(name: 'grandparent').returns(@grandparent_model)
      @child_model.grandparent_test_method_nil.must_equal( @grandparent_model.grandparent_test_method_nil)
    end

    it 'should inherit attributes that are nil from another model up the chain' do
      ParentModel.expects(:first).with(name: 'parent').returns(@parent_model)
      GrandParentModel.expects(:first).with(name: 'grandparent').returns(@grandparent_model)
      @child_model.grandparent_test_attribute_nil.must_equal( @grandparent_model.grandparent_test_attribute_nil)
    end    

  end

end

