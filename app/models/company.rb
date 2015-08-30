class Company < ActiveRecord::Base
  has_many :projects

  validates :name, presence: true
  validates :description, presence: true
  validates :url, presence: true, uniqueness: true

  before_validation :generate_url

  def generate_url
    self.url = name.parameterize
  end

  def self.count_active_projects(projects)
    projects.find_all { |project| project.funding_in_percentage < 100 }.count
  end
end
