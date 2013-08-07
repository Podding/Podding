# encoding: utf-8

class Audioformat < Model
  attribute :file_extension
  attribute :suffix

  def extension
    data["extension"] || ".#{ self.name }"
  end

  def suffix
    data["suffix"] || ""
  end

  def file_extension
    self.suffix + self.extension
  end

end
