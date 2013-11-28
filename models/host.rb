# encoding: utf-8

class Host < Mlk::Model

  attribute :full_name
  attribute :twitter_name
  attribute :flattr_name
  attribute :wishlist_url
  attribute :image_url
  attribute :blog_url
  attribute :quip
  attribute :guest

  has_many :Episode, :episodes, :hosts

  def validate
    # Required attributes
    assert_present :full_name
    assert_url :image_url

    # Optional attributes
    assert_url :wishlist_url if self.wishlist_url
    assert_url :blog_url if self.blog_url
    super
  end

end

