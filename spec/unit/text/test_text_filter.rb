# encoding: utf-8

require_relative '../helper'

class ZeroethFilter < TextFilter
  expects :text
end

class ThirdFilter < TextFilter
  expects :html

  # Needed for external access to @settings instance variable
  attr_reader :settings

end

class SecondFilter < TextFilter
  defaults test: 42
  priority 0

  # Needed for external access to @settings instance variable
  attr_reader :settings

end

class FirstFilter < TextFilter
  defaults test: 0
  expects :markdown

  # Needed for external access to @settings instance variable
  attr_reader :settings

end

describe TextFilter do

  before do
    TextFilterEngine.register_filter(FirstFilter)
    TextFilterEngine.register_filter(SecondFilter)
    TextFilterEngine.register_filter(ThirdFilter)
    TextFilterEngine.register_filter(ZeroethFilter)
    @settings = {test: 1}
    @filter_1 = FirstFilter.new(@settings)
    @filter_2 = SecondFilter.new
    @filter_3 = ThirdFilter.new
    @filter_0 = ZeroethFilter.new
  end

  after do
    TextFilterEngine.unregister_filter(FirstFilter)
    TextFilterEngine.unregister_filter(SecondFilter)
    TextFilterEngine.unregister_filter(ThirdFilter)
    TextFilterEngine.unregister_filter(ZeroethFilter)
  end

  describe 'filters' do

    it 'should keep track of subclasses' do
      TextFilterEngine.filters.must_include(FirstFilter)
      TextFilterEngine.filters.must_include(SecondFilter)
      TextFilterEngine.filters.must_include(ThirdFilter)
    end

  end

  describe 'defaults' do
    it 'should create empty defaults' do
      ThirdFilter.defaults.must_equal({})
    end

    it 'should keep defaults if no settings are passed' do
      @filter_2.settings.must_equal({test: 42})
    end

    it 'should overwrite defaults with explicit settings' do
      @filter_1.settings.must_equal(@settings)
    end
  end

  describe 'priority' do
    it 'should assign priority when explicitly stated' do
      SecondFilter.priority.must_equal(0)
    end

    it 'should sort filters according to their expectations' do
      TextFilterEngine.filters.sort.must_equal([ZeroethFilter, FirstFilter, SecondFilter, ThirdFilter])
    end
  end

end

