# encoding: utf-8

require_relative '../helper'
require 'ostruct'

describe Finders do

  before do
    class TestModel
      extend Finders

      def self.all
        [
          OpenStruct.new(data: { 'name' => 'foo', 'show' => 'oww', 'a' => 'x' }),
          OpenStruct.new(data: { 'name' => 'bar', 'show' => 'oww', 'a' => 'c' }),
          OpenStruct.new(data: { 'name' => 'lol', 'show' => 'oww', 'a' => 'c' }),
          OpenStruct.new(data: { 'name' => 'asdf', 'show' => 'hjl', 'a' => 'b' }),

          OpenStruct.new(data: { 'name' => 'huh', 'arr' => %w{ foo bar baz } }),
          OpenStruct.new(data: { 'name' => 'WAT', 'arr' => %w{ jo no baz } })
        ]
      end
    end

    TestModel.find
  end

  describe '#first' do

    it 'can find a single element by attribute' do
      TestModel.first(name: 'foo').must_equal(
        OpenStruct.new(data: { 'name' => 'foo', 'show' => 'oww', 'a' => 'x' })
      )
      TestModel.first(name: 'bar').must_equal(
        OpenStruct.new(data: { 'name' => 'bar', 'show' => 'oww', 'a' => 'c' })
      )
    end

    it 'can find a single element by multiple attributes' do
      TestModel.first(show: 'oww', 'a' => 'x').must_equal(
        OpenStruct.new(data: { 'name' => 'foo', 'show' => 'oww', 'a' => 'x' })
      )
    end

    it 'can find multiple elements by attribute' do
      result = TestModel.first(show: 'oww')
      result.must_equal OpenStruct.new(data: { 'name' => 'foo', 'show' => 'oww', 'a' => 'x' })
    end

  end

  describe '#find' do

    it 'can find a single element by attribute' do
      TestModel.find(name: 'foo').must_equal(
        [OpenStruct.new(data: { 'name' => 'foo', 'show' => 'oww', 'a' => 'x' })]
      )
    end

    it 'can find multiple elements by attribute' do
      result = TestModel.find(show: 'oww')
      result.must_be_kind_of(Enumerable)
      result.size.must_equal 3
      result.must_include OpenStruct.new(data: { 'name' => 'foo', 'show' => 'oww', 'a' => 'x' })
      result.must_include OpenStruct.new(data: { 'name' => 'bar', 'show' => 'oww', 'a'=> 'c' })
      result.must_include OpenStruct.new(data: { 'name' => 'lol', 'show' => 'oww', 'a'=> 'c' })
    end

    it 'can find multiple elements by multiple attributes' do
      result = TestModel.find(show: 'oww', 'a' => 'c')
      result.must_be_kind_of(Enumerable)
      result.size.must_equal 2
      result.must_include OpenStruct.new(data: { 'name' => 'bar', 'show' => 'oww', 'a'=> 'c' })
      result.must_include OpenStruct.new(data: { 'name' => 'lol', 'show' => 'oww', 'a'=> 'c' })
    end

  end


  describe '#find_match' do

    it 'can find elements by single match attribute' do
      result = TestModel.find_match(arr: "baz")
      result.must_be_kind_of(Enumerable)
      result.size.must_equal 2
      result.must_include OpenStruct.new(data: { 'name' => 'huh', 'arr' => %w{ foo bar baz } })
      result.must_include OpenStruct.new(data: { 'name' => 'WAT', 'arr' => %w{ jo no baz } })
    end

    it 'can find elements by multiple match attributes' do
      result = TestModel.find_match(arr: 'baz', name: 'WAT')
      result.must_be_kind_of(Enumerable)
      result.size.must_equal 1
      result.must_include OpenStruct.new(data: { 'name' => 'WAT', 'arr' => %w{ jo no baz } })
    end

  end

end
