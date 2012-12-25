# encoding: utf-8

require 'minitest/spec'
require 'minitest/autorun'
require 'mocha/setup'

require 'pry'
require 'pry-nav'

require_relative '../../lib/podding'
require_relative '../../lib/podding/storage_engines/memory_storage'
require_relative '../../models/init'
require_relative '../../helpers/init'

Model.storage_engine = MemoryStorage
