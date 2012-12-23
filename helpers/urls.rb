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

  def twitter_url(host)
    "https://twitter.com/#{ host.twitter_name }"
  end

  def flattr_url(host)
    "https://flattr.com/profile/#{ host.flattr_name }"
  end

end
