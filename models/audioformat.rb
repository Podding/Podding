# encoding: utf-8

class Audioformat < Model
  attribute :file_extension
  attribute :suffix

  def extension
    if data["extension"] # default to something smart if nothing is declared
      data["extension"]
    else
      ".#{ self.name }"
    end
  end # extension

  def suffix
    if data["suffix"] # default to something smart if nothing is declared
      data["suffix"]
    else 
      ""
    end
  end # suffix

  def file_extension # this is what is used to build an audio file url
    self.suffix + self.extension
  end # file_extension

end # audioformat