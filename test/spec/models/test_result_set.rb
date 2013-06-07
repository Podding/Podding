# encoding: utf-8

require_relative '../helper'

describe ResultSet do

  before do
    @all =     [
      OpenStruct.new(data: { 'name' => 'foo', 'show' => 'oww', 'a' => 'x' }),
      OpenStruct.new(data: { 'name' => 'bar', 'show' => 'oww', 'a' => 'c' }),
      OpenStruct.new(data: { 'name' => 'lol', 'show' => 'oww', 'a' => 'c' }),
      OpenStruct.new(data: { 'name' => 'asdf', 'show' => 'hjl', 'a' => 'b' }),

      OpenStruct.new(data: { 'name' => 'huh', 'arr' => %w{ foo bar baz } }),
      OpenStruct.new(data: { 'name' => 'WAT', 'arr' => %w{ jo no baz } }),

      OpenStruct.new(data: { 'name' => 'a', 'other_value' => 'ha' }),
      OpenStruct.new(data: { 'name' => 'b', 'other_value' => 'ho' })
    ]

    @default_set = ResultSet.new(@all)
  end

  describe '#initialize' do

    it 'sets the correct results' do
      ResultSet.new(@all).results.must_equal(@all)
    end

    it 'thows an error when invalid results are passed' do
      lambda { ResultSet.new('') }.must_raise(ArgumentError)
    end

  end

  describe '#first' do

    it 'can find a single element by attribute' do
      @default_set.first(name: 'foo').must_equal(
        OpenStruct.new(data: { 'name' => 'foo', 'show' => 'oww', 'a' => 'x' })
      )
      @default_set.first(name: 'bar').must_equal(
        OpenStruct.new(data: { 'name' => 'bar', 'show' => 'oww', 'a' => 'c' })
      )
    end

    it 'can find a single element by multiple attributes' do
      @default_set.first(show: 'oww', 'a' => 'x').must_equal(
        OpenStruct.new(data: { 'name' => 'foo', 'show' => 'oww', 'a' => 'x' })
      )
    end

    it 'can find multiple elements by attribute' do
      result = @default_set.first(show: 'oww')
      result.must_equal OpenStruct.new(data: { 'name' => 'foo', 'show' => 'oww', 'a' => 'x' })
    end

  end

  describe '#find' do

    it 'retuns an empty array when filters do not match' do
      @default_set.find(non_existing_attribute: 'non_existing_value').must_be_empty
    end

    it 'cannot find elements without any filters' do
      lambda { @default_set.find }.must_raise ArgumentError
    end

    it 'cannot find elements without a filters hash' do
      lambda { @default_set.find('trololo') }.must_raise ArgumentError
    end

    it 'can find a single element by attribute' do
      @default_set.find(name: 'foo').must_equal(ResultSet.new(
        [OpenStruct.new(data: { 'name' => 'foo', 'show' => 'oww', 'a' => 'x' })]
      ))
    end

    it 'can find multiple elements by attribute' do
      result = @default_set.find(show: 'oww')
      result.must_be_kind_of(ResultSet)
      result.size.must_equal 3
      result.must_include OpenStruct.new(data: { 'name' => 'foo', 'show' => 'oww', 'a' => 'x' })
      result.must_include OpenStruct.new(data: { 'name' => 'bar', 'show' => 'oww', 'a'=> 'c' })
      result.must_include OpenStruct.new(data: { 'name' => 'lol', 'show' => 'oww', 'a'=> 'c' })
    end

    it 'can find multiple elements by multiple attributes' do
      result = @default_set.find(show: 'oww', 'a' => 'c')
      result.must_be_kind_of(ResultSet)
      result.size.must_equal 2
      result.must_include OpenStruct.new(data: { 'name' => 'bar', 'show' => 'oww', 'a'=> 'c' })
      result.must_include OpenStruct.new(data: { 'name' => 'lol', 'show' => 'oww', 'a'=> 'c' })
    end

    it 'can find elements by attribute existance' do
      result = @default_set.find(other_value: :exists)
      result.size.must_equal 2
    end

  end

  describe '#find_match' do

    it 'retuns an empty array when filters do not match' do
      @default_set.find_match(non_existing_attribute: 'non_existing_value').must_be_empty
    end

    it 'cannot find elements without any filters' do
      lambda { @default_set.find_match }.must_raise ArgumentError
    end

    it 'cannot find elements without a filters hash' do
      lambda { @default_set.find_match('fufu') }.must_raise ArgumentError
    end

    it 'can find elements by single match attribute' do
      result = @default_set.find_match(arr: "baz")
      result.must_be_kind_of(ResultSet)
      result.size.must_equal 2
      result.must_include OpenStruct.new(data: { 'name' => 'huh', 'arr' => %w{ foo bar baz } })
      result.must_include OpenStruct.new(data: { 'name' => 'WAT', 'arr' => %w{ jo no baz } })
    end

    it 'can find elements by multiple match attributes' do
      result = @default_set.find_match(arr: 'baz', name: 'WAT')
      result.must_be_kind_of(ResultSet)
      result.size.must_equal 1
      result.must_include OpenStruct.new(data: { 'name' => 'WAT', 'arr' => %w{ jo no baz } })
    end

    it 'can find elements by regex' do
      result = @default_set.find_match(name: /(foo|bar)/)
      result.size.must_equal 2
      result.must_include OpenStruct.new(data: { 'name' => 'foo', 'show' => 'oww', 'a' => 'x' })
      result.must_include OpenStruct.new(data: { 'name' => 'bar', 'show' => 'oww', 'a'=> 'c' })
    end

  end



  describe '#group_by' do

    it 'can group results by attribute' do
      grouped = ResultSet.new(@all).group_by(:show)

      @all.each do |result|
        grouped[result.show].must_include(result)
      end

    end

  end

  describe '#sort_by' do

    it 'can sort results by attribute' do
      sorted = ResultSet.new(@all).sort_by(:name)
      sorted.must_equal(ResultSet.new(@all.sort_by(&:name)))
    end

  end

  describe '#find' do

    it 'can find results by attribute' do
      found = ResultSet.new(@all).find(show: 'oww')
      found.must_be_kind_of(ResultSet)

      found.must_equal(ResultSet.new([
        OpenStruct.new(data: { 'name' => 'foo', 'show' => 'oww', 'a' => 'x' }),
        OpenStruct.new(data: { 'name' => 'bar', 'show' => 'oww', 'a' => 'c' }),
        OpenStruct.new(data: { 'name' => 'lol', 'show' => 'oww', 'a' => 'c' })
      ]))
    end

    it 'supports chained find()' do
      found = ResultSet.new(@all).find(show: 'oww')
      found.find(name: 'bar').must_equal(ResultSet.new([
        OpenStruct.new(data: { 'name' => 'bar', 'show' => 'oww', 'a' => 'c' })
      ]))
    end

  end

end

