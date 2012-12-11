# encoding: utf-8

class Host < Model

  attribute :full_name
  attribute :twitter
  attribute :flattr
  attribute :wishlist_url
  attribute :image_url
  attribute :blog_url
  attribute :quip

  has_many :episodes, :Episode, :hosts

  def initialize(options = {})
    super(options)
  end

  def default_template
    :hosts
  end

  def validate
    assert_url :wishlist_url
    assert_url :image_url
    assert_url :blog_url
    super
  end

end
