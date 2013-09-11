module Localisation
  include Helper
  
  def t(*args)
    I18n.t(*args)
  end

end