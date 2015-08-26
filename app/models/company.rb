class Company < ActiveRecord::Base
  has_many :projects

  validates :name, presence: true, uniqueness: true
  validates :description, presence: true

  before_validation :generate_url
  
  def generate_url
    self.url = name.parameterize
  end
end
