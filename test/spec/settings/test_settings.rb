# encoding: utf-8

require_relative '../helper'


describe Settings do

  before do
    @settings_file = %Q{
      test1: test1
    }
    @settings = Settings.new(@settings_file)
  end

  describe 'init' do
    it 'should set @settings to the YAML-processed content of the settings file' do
      @settings.settings.must_equal(YAML.load(@settings_file))
    end
  end

  describe 'lookup' do
    it 'should return the value if method name matches key' do
      @settings.test1.must_equal("test1")
    end

    it 'should return nil if no method name matches key' do
      @settings.test2.must_equal(nil)
    end
  end

end

