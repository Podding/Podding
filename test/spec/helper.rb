# encoding: utf-8

require 'minitest/spec'
require 'minitest/autorun'
require 'mocha/setup'

require 'ostruct'

require 'pry'
require 'pry-debugger'

require_relative '../../lib/podding'
require_relative '../../lib/podding/storage_engines/memory_storage'
require_relative '../../models/init'
require_relative '../../helpers/init'

Model.storage_engine = MemoryStorage

def generate_document(header, content = '')
<<-EOF
---
#{ header.inject('') { |acc, val| acc +=  "#{ val[0] }: #{ val[1] }\n" } }
---
#{ content }
EOF
end

def mock_document(attributes)
  mock_content = mock()
  attributes.each do |attr, value|
    mock_content.expects(attr).returns(value)
  end

  mock_content
end
