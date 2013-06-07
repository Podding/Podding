# encoding: utf-8

require_relative '../helper'

describe Model do

  it "can't be created without content" do
    lambda { Model.new({ }) }.must_raise(ArgumentError)
  end

  it 'can\t be created with empty content' do
    lambda { Model.new(raw_content: '') }.must_raise(RuntimeError)
  end

  it 'can\'t be created without a YAML header and content' do
    content = "CONTENT"
    lambda { Model.new(raw_content: content) }.must_raise(RuntimeError)
  end

  it 'can be created with data and empty content' do
    model = Model.new(raw_content: "---\n foo: bar \n---")
    model.must_be_instance_of Model
    model.content.must_equal ''
    model.data.must_equal({ 'foo' => 'bar' })
  end

  it "can't be created with a broken YAML header" do
    content = generate_document({ 'foo' => '[' })
    lambda { Model.new(raw_content: content) }.must_raise(RuntimeError)
  end

  it 'can be created with a valid YAML header' do
    header = { 'foo' => 'bar', 'hurr' => 'durr', 'trolo' => 'lala' }
    content = generate_document(header)
    Model.new(raw_content: content).data.must_equal(header)
  end

  it 'can be created with a YAML header and content' do
    content = generate_document({ 'asdf' => 'hjkl'}, 'THIS IS SPARTA!')
    Model.new(raw_content: content).content.must_equal "THIS IS SPARTA!"
  end

  it 'should be invalid without a name' do
    content = generate_document({ 'noname' => 'gnah' }, 'CONTENT')
    Model.new(raw_content: content).valid?.must_equal false
  end

  it 'should be valid with a name' do
    content = generate_document({ 'name' => 'dawg' }, 'CONTENT')
    Model.new(raw_content: content).valid?.must_equal true
  end

  it 'should serialize a valid representation of itself' do
    content = generate_document({ 'name' => 'serialize_me' }, 'CONTENT')
    model = Model.new(raw_content: content)
    new_model = Model.new(raw_content: model.serialize)
    new_model.must_equal model
  end

end

