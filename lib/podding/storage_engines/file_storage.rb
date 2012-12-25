# encoding: utf-8

class FileStorage

  class << self
    attr_accessor :base_path
  end

  def initialize(namespace)
    @namespace = namespace
  end

  def all
    all_files = scan_files

    all_files.each_with_object({ }) do |path, hsh|
      hsh[path] = File.read(path)
    end
  end

  def save(model)
    # currently a no-op
  end

  private

  def path
    "#{ self.class.base_path }/#{ @namespace }"
  end

  def scan_files
    files = "#{ path }/**/*.{markdown,md}"
    Dir[files]
  end

end
