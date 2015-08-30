class Company < ActiveRecord::Base
  has_many :projects
  has_many :users

  validates :name, presence: true
  validates :description, presence: true
  validates :url, presence: true, uniqueness: true

  before_validation :generate_url

  def generate_url
    self.url = name.parameterize
  end

  def sorted_projects
    projects.sort_by(&:funding_in_percentage)
  end
end
