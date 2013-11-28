# encoding: utf-8

require_relative '../helper'

class DefaultsFilter < TextFilter
  defaults test: 42
  # Needed for external access to @settings instance variable
  attr_reader :settings
end

class PrioFilter < TextFilter
  priority 2342
end

class AFilter < TextFilter ; priority 10; end
class BFilter < TextFilter ; priority 0; end
class CFilter < TextFilter ; priority 5; end

describe TextFilter do

  describe '::defaults' do

    it 'should create empty defaults' do
      TextFilter.defaults.must_equal({})
    end

    it 'should keep defaults if no settings are passed' do
      DefaultsFilter.new.settings.must_equal({ test: 42 })
    end

    it 'should merge defaults with explicit settings' do
      settings = { foo: 'bar' }
      filter = DefaultsFilter.new(settings)
      filter.settings.must_equal({ test: 42, foo: 'bar' })
    end

    it 'should overwrite defaults when explicitly specified' do
      filter = DefaultsFilter.new({ test: 1337 })
      filter.settings.must_equal({ test: 1337 })
    end

  end

  describe '::priority' do

    it 'should assign priority when explicitly stated' do
      PrioFilter.priority.must_equal(2342)
    end

    it 'should sort filters according to their expectations' do
      [AFilter, BFilter, CFilter].sort.must_equal([BFilter, CFilter, AFilter])
    end

  end

  describe '#render' do

    it 'should raise an exception when not overridden' do
      lambda do
        TextFilter.new.render('')
      end.must_raise(NotImplementedError)
    end

  end

end

