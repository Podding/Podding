# encoding: utf-8

require_relative '../helper'

class Filter1 < TextFilter
  
end

describe TextFilterEngine do

  describe 'register filter' do
    it 'should add registered filters to filters array' do
      TextFilterEngine.register_filter(Filter1)
      TextFilterEngine.filters.must_equal([Filter1])
    end
  end

  describe 'unregister filter' do
    it 'should remove unregistered filters from filters array' do
      TextFilterEngine.unregister_filter(Filter1)
      TextFilterEngine.filters.must_equal([])
    end
  end

end

