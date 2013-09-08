# encoding: utf-8

module URLs
  include Helper

  def url_for(model)
    namespace = Utils.pluralize(model.class.name.downcase)
    name = model.name

    if namespace == 'episodes'
      show_name = model.show.name
      "/shows/#{ show_name }/#{ name }"
    elsif namespace == 'pages'
      return "/#{ name }" if model.is_special
      "/pages/#{ name }"
    else
      "/#{ namespace }/#{ name }"
    end
  end

  def twitter_url(host)
    "https://twitter.com/#{ host.twitter_name }"
  end

  def flattr_url(host)
    "https://flattr.com/profile/#{ host.flattr_name }"
  end

end
