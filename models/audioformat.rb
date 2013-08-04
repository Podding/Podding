# encoding: utf-8

class Audioformat < Model
  attribute :file_extension
  attribute :suffix

  def file_extension
    if data["file_extension"] # default to something smart if nothing is declared
      data["file_extension"]
    else
      ".#{ self.name }"
    end
  end

  def suffix
    if data["suffix"] # default to something smart if nothing is declared
      data["suffix"]
    else 
      ""
    end
  end
end #audioformat