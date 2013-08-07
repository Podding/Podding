# encoding: utf-8

require_relative '../helper'

Result = Struct.new(:data)

describe ResultSet do

  let(:all) do
    [
      Result.new({ 'name' => 'foo', 'show' => 'oww', 'a' => 'x' }),
      Result.new({ 'name' => 'bar', 'show' => 'oww', 'a' => 'c' }),
      Result.new({ 'name' => 'lol', 'show' => 'oww', 'a' => 'c' }),
      Result.new({ 'name' => 'asdf', 'show' => 'hjl', 'a' => 'b' }),

      Result.new({ 'name' => 'huh', 'arr' => %w{ foo bar baz } }),
      Result.new({ 'name' => 'WAT', 'arr' => %w{ jo no baz } }),

      Result.new({ 'name' => 'a', 'other_value' => 'ha' }),
      Result.new({ 'name' => 'b', 'other_value' => 'ho' })
    ]
  end

  let(:default_set) { ResultSet.new(all) }

  describe '#initialize' do

    it 'sets the correct results' do
      ResultSet.new([ ]).results.must_equal([ ])
    end

    it 'freezes the passed in results object' do
      ResultSet.new([ ]).results.frozen?.must_equal(true)
    end

    it 'checks the passed in results object if it is enumerable' do
      results = mock
      results.expects(:kind_of?).with(Enumerable).returns(true)
      ResultSet.new(results)
    end

    it 'thows an error when invalid results are passed' do
      lambda { ResultSet.new(nil) }.must_raise(ArgumentError)
      lambda { ResultSet.new('') }.must_raise(ArgumentError)
    end

  end

  describe '#first' do

    it 'can find a single element by attribute' do
      result = default_set.first(name: 'foo')
      result.must_equal(Result.new({ 'name' => 'foo', 'show' => 'oww', 'a' => 'x' }))
    end

    it 'can find a single element by multiple attributes' do
      result = default_set.first(show: 'oww', 'a' => 'x')
      result.must_equal(Result.new({ 'name' => 'foo', 'show' => 'oww', 'a' => 'x' }))
    end

    it 'can find multiple elements by attribute' do
      result = default_set.first(show: 'oww')
      result.must_equal(Result.new({ 'name' => 'foo', 'show' => 'oww', 'a' => 'x' }))
    end

  end

  describe '#find' do

    it 'returns an empty array when filters do not match' do
      default_set.find(non_existing_attribute: 'non_existing_value').must_be_empty
    end

    it 'cannot find elements without any filters' do
      lambda { default_set.find }.must_raise(ArgumentError)
    end

    it 'cannot find elements without a filters hash' do
      lambda { default_set.find('trololo') }.must_raise(ArgumentError)
    end

    it 'can find a single element by attribute' do
      default_set.find(name: 'foo').must_equal(ResultSet.new(
        [Result.new({ 'name' => 'foo', 'show' => 'oww', 'a' => 'x' })]
      ))
    end

    it 'can find multiple elements by attribute' do
      result = default_set.find(show: 'oww')
      result.must_be_kind_of(ResultSet)
      result.size.must_equal(3)
      result.must_include Result.new({ 'name' => 'foo', 'show' => 'oww', 'a' => 'x' })
      result.must_include Result.new({ 'name' => 'bar', 'show' => 'oww', 'a'=> 'c' })
      result.must_include Result.new({ 'name' => 'lol', 'show' => 'oww', 'a'=> 'c' })
    end

    it 'can find multiple elements by multiple attributes' do
      result = default_set.find(show: 'oww', 'a' => 'c')
      result.must_be_kind_of(ResultSet)
      result.size.must_equal(2)
      result.must_include Result.new({ 'name' => 'bar', 'show' => 'oww', 'a'=> 'c' })
      result.must_include Result.new({ 'name' => 'lol', 'show' => 'oww', 'a'=> 'c' })
    end

    it 'can find elements by attribute existance' do
      result = default_set.find(other_value: :exists)
      result.size.must_equal(2)
    end

    it 'can find results by attribute' do
      found = default_set.find(show: 'oww')
      found.must_be_kind_of(ResultSet)

      found.must_equal(ResultSet.new([
        Result.new({ 'name' => 'foo', 'show' => 'oww', 'a' => 'x' }),
        Result.new({ 'name' => 'bar', 'show' => 'oww', 'a' => 'c' }),
        Result.new({ 'name' => 'lol', 'show' => 'oww', 'a' => 'c' })
      ]))
    end

    it 'supports chained find()' do
      found = ResultSet.new(all).find(show: 'oww')
      found.find(name: 'bar').must_equal(ResultSet.new([
        Result.new({ 'name' => 'bar', 'show' => 'oww', 'a' => 'c' })
      ]))
    end

  end

  describe '#find_match' do

    it 'retuns an empty array when filters do not match' do
      default_set.find_match(non_existing_attribute: 'non_existing_value').must_be_empty
    end

    it 'cannot find elements without any filters' do
      lambda { default_set.find_match }.must_raise(ArgumentError)
    end

    it 'cannot find elements without a filters hash' do
      lambda { default_set.find_match('fufu') }.must_raise(ArgumentError)
    end

    it 'can find elements by single match attribute' do
      result = default_set.find_match(arr: "baz")
      result.must_be_kind_of(ResultSet)
      result.size.must_equal(2)
      result.must_include Result.new({ 'name' => 'huh', 'arr' => %w{ foo bar baz } })
      result.must_include Result.new({ 'name' => 'WAT', 'arr' => %w{ jo no baz } })
    end

    it 'can find elements by multiple match attributes' do
      result = default_set.find_match(arr: 'baz', name: 'WAT')
      result.must_be_kind_of(ResultSet)
      result.size.must_equal(1)
      result.must_include Result.new({ 'name' => 'WAT', 'arr' => %w{ jo no baz } })
    end

    it 'can find elements by regex' do
      result = default_set.find_match(name: /(foo|bar)/)
      result.size.must_equal(2)
      result.must_include Result.new({ 'name' => 'foo', 'show' => 'oww', 'a' => 'x' })
      result.must_include Result.new({ 'name' => 'bar', 'show' => 'oww', 'a'=> 'c' })
    end

  end

  describe '#group_by' do

    let(:grouped) do
      ResultSet.new([
        mock_with_attributes(show: 'foo'),
        mock_with_attributes(show: 'bar'),
        mock_with_attributes(show: 'baz')
      ]).group_by(:show)
    end

    it 'can group results by attribute' do
      grouped.size.must_equal(3)
    end

    it 'contains the right keys' do
      grouped.keys.must_include('foo')
      grouped.keys.must_include('bar')
      grouped.keys.must_include('baz')
    end

    it 'returns empty arrays for keys not available' do
      grouped[:does_not_exist].must_equal([ ])
    end

  end

  describe '#sort_by' do

    it 'can sort results by attribute' do
      results = mock
      results.expects(:kind_of?).with(Enumerable).returns(true)
      results.expects(:sort_by).returns([ ])

      ResultSet.new(results).sort_by(:name).results.must_equal([ ])
    end

  end

end

