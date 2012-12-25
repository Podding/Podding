require 'rake/testtask'

require_relative 'lib/podding'
require_relative 'models/init'

source_dir = File.dirname(__FILE__) + '/source'
FileStorage.base_path = source_dir
Model.storage_engine = FileStorage

# Model stuff

desc 'Validate all entries of all models'
task :model_validate do
  Model.defined_models.each do |model|
    model.all.each do |entry|
      unless entry.valid?
        puts "Found invalid data in #{ model.name }: #{ entry.path } (#{ entry.errors.inspect })"
        puts "--------------------------"
      end
    end
  end
end


# Tests

Rake::TestTask.new do |t|
  t.name = 'test'
  t.pattern = 'test/integration/**/test_*.rb'
  t.verbose = true
end

Rake::TestTask.new do |t|
  t.name = 'spec'
  t.pattern = 'test/spec/**/test_*.rb'
  t.verbose = true
end
