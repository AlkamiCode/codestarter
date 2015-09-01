class Category < ActiveRecord::Base
  before_create :make_slug
  has_many :items

  def make_slug
    self.slug = name.downcase.gsub(" ", "-")
  end

  def to_param
    name.downcase.gsub(" ", "-")
  end

end
