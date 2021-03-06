class Company < ActiveRecord::Base
  attr_reader :collaborators
  has_many :projects
  has_many :users

  validates :name, presence: true
  validates :description, presence: true
  validates :url, presence: true, uniqueness: true

  before_validation :generate_url

  def generate_url
    self.url = name.parameterize
  end

  def collaborators
    users = User.where(company_id: id)
    users.reject(&:company_admin?)
  end

  def company_admins
    users = User.where(company_id: id)
    users.select(&:company_admin?)
  end

  def former_collaborators
    User.where(company_id: id)
  end

  def sorted_projects
    projects.sort_by(&:funding_in_percentage)
  end
end
