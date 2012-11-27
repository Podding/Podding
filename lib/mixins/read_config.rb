module Config
  def self.load(path)
    file = File.read(path)
    YAML.load(file)
  end
end