# encoding: utf-8

require 'minitest/spec'
require 'minitest/autorun'
require 'mocha/setup'

require 'ostruct'

require 'pry'
require 'pry-byebug'

require 'mlk'
require 'mlk/storage_engines/memory_storage'

require_relative '../../lib/podding'
require_relative '../../models/init'
require_relative '../../helpers/init'

Mlk::Model.storage_engine = MemoryStorage

def generate_document(header, content = '')
<<-EOF
---
#{ header.inject('') { |acc, val| acc +=  "#{ val[0] }: #{ val[1] }\n" } }
---
#{ content }
EOF
end

def mock_with_attributes(attributes)
  mock_obj = mock
  attributes.each do |attr, value|
    mock_obj.expects(attr).returns(value)
  end

  mock_obj
end
