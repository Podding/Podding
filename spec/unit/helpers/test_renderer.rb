# encoding: utf-8

require_relative '../helper'

describe Renderer do
  include Renderer

  MyTestClass = Struct.new(:content) do
    def to_str
      self.content
    end
  end

  it 'should render a given string by pushing it through the TextFilter pipeline' do
    TextFilterEngine.expects(:render).with('Given string!', { })

    render_content('Given string!')
  end

  it 'should render a given object which has an implicit sting conversion ' do
    content = MyTestClass.new('Given content')
    TextFilterEngine.expects(:render).with(content, { })
    render_content(content)
  end

  it 'should pass an options hash to the render pipeline' do
    options = { foo: 'bar', baz: 'derp' }
    TextFilterEngine.expects(:render).with('foo', options)

    render_content('foo', options)
  end

end

