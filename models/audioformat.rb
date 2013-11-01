# encoding: utf-8

class Audioformat < Mlk::Model
  attribute :file_extension
  attribute :suffix

  def extension
    return data["extension"] if data["extension"]
    ".#{ self.name }"
  end

  def suffix
    return data["suffix"] if data["suffix"]
    ""
  end

  def file_extension # this is what is used to build an audio file url
    self.suffix + self.extension
  end

end

