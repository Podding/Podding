# encoding: utf-8

require_relative '../helper'

describe Document do

  describe '#initialize' do

    it 'can\t be created with empty string' do
      lambda { Document.new('') }.must_raise(RuntimeError)
    end

    it 'can\'t be created without a YAML header' do
      doc = "CONTENT"
      lambda { Document.new(doc) }.must_raise(RuntimeError)
    end

    it "can't be created with a broken YAML header" do
      doc = generate_document({ 'foo' => '[' })
      lambda { Document.new(doc) }.must_raise(RuntimeError)
    end

    it 'can be created with data and empty content' do
      model = Document.new("---\n foo: bar \n---")
      model.must_be_instance_of(Document)
      model.content.must_equal('')
      model.data.must_equal({ 'foo' => 'bar' })
    end

    it 'can be created with a valid YAML header' do
      header = { 'foo' => 'bar', 'hurr' => 'durr', 'trolo' => 'lala' }
      doc = generate_document(header)
      Document.new(doc).data.must_equal(header)
    end

    it 'can be created with a YAML header and content' do
      doc = generate_document({ 'asdf' => 'hjkl'}, 'THIS IS SPARTA!')
      document = Document.new(doc)
      document.content.must_equal("THIS IS SPARTA!")
    end

  end

  describe '#serialize' do

    it 'can serialize a valid representation of itself' do
      doc = generate_document({ 'name' => 'serialize_me' }, 'CONTENT')
      document = Document.new(doc)
      new_document = Document.new(document.serialize)
      new_document.must_equal(document)
    end

  end

end


