# encoding: utf-8

class Audioformat < Mlk::Model
  attribute :file_extension
  attribute :suffix
  attribute :mime_type

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

