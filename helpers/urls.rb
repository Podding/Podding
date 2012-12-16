# encoding: utf-8

module URLs
  include Helper

  def url_for(model)
    namespace = model.class.name.downcase + "s"
    name = model.name

    if namespace == 'episodes'
      show_name = model.show.name
      "/shows/#{ show_name }/#{ name }"
    else
      "/#{ namespace }/#{ name }"
    end
  end

end
