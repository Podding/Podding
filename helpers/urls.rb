# encoding: utf-8

module URLs
  include Helper

  def url_for(model)
    namespace = model.class.name.downcase + "s"
    name = model.name

    "/#{ namespace }/#{ name }"
  end

end
