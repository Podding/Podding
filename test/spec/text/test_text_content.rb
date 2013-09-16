# encoding: utf-8

require_relative '../helper'

describe TextContent do
  
  before do

    class Filter < TextFilter
      defaults replace: 't'
      def render(text)
        text.sub(@settings[:replace],"_")
      end
    end

    @settings = {replace: "e"}
    @text = TextContent.new("It's tested.")
    @empty_text = TextContent.new
    TextFilterEngine.register_filter(Filter)

  end

  after do
    TextFilterEngine.unregister_filter(Filter)
  end

  describe 'initialize' do
    it 'should keep its raw data unchanged' do
      TextContent.new("A string.").raw.must_equal("A string.")
    end
  end

  describe 'render' do
    it 'should render with defaults' do
      @text.render.must_equal("I_'s tested.")
    end

    it 'should render with settings' do
      @text.render(@settings).must_equal("It's t_sted.")
    end
  end

  describe 'empty?' do
    it 'should return true if empty' do
      @empty_text.empty?.must_equal(true)
    end

    it 'should return false if not empty' do
      @text.empty?.must_equal(false)
    end
  end

  describe 'to_s' do
    it 'should return the raw content' do
      @text.to_s.must_equal("It's tested.")
    end
  end

end

