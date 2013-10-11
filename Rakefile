require 'rake/testtask'


# Model stuff

desc 'Validate all entries of all models'
task :model_validate do
  require 'mlk'
  require 'mlk/storage_engines/file_storage'
  require_relative 'lib/podding'
  require_relative 'models/init'

  source_dir = File.dirname(__FILE__) + '/source'
  Mlk::FileStorage.base_path = source_dir
  Mlk::Model.storage_engine = Mlk::FileStorage
  Mlk::Model.defined_models.each do |model|
    model.all.each do |entry|
      unless entry.valid?
        puts "Found invalid data in #{ model.name }: #{ entry.path } (#{ entry.errors.inspect })"
        puts "--------------------------"
      end
    end
  end
end


# Tests

desc 'Execute all the tests'
task :test do
  Rake::Task["unit"].invoke
  Rake::Task["integration"].invoke
end

Rake::TestTask.new do |t|
  t.name = 'integration'
  t.pattern = 'spec/integration/**/test_*.rb'
  t.verbose = true
end

Rake::TestTask.new do |t|
  t.name = 'unit'
  t.pattern = 'spec/unit/**/test_*.rb'
  t.verbose = true
end
