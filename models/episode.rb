# encoding: utf-8

class Episode < Model

  def initialize(options = {})
    super(options)
  end

  def content_path
    @path
  end

  def default_template
    :episode
  end

  def hosts
    @meta_data["hosts"].map do |host|
      Host.first(name: host)
    end
  end
end
