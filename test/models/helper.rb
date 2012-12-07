# encoding: utf-8

require 'minitest/autorun'
require 'minitest/benchmark'

require_relative '../../lib/podding'
require_relative '../../models/init'

Model.base_path = File.dirname(__FILE__) + '/../source'
