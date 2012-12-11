# encoding: utf-8

require 'minitest/autorun'
require 'minitest/benchmark'

require 'w3c_validators'

require_relative '../../lib/podding'
require_relative '../../helpers/urls'

Model.base_path = File.dirname(__FILE__) + '/../source'
