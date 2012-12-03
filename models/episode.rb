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
    if host_names = @meta_data["hosts"]
      host_names.map do |host|
        Host.first(name: host)
      end
    else
      [ ]
    end
  end
end
