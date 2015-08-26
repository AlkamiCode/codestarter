class Company < ActiveRecord::Base
  has_many :projects

  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
end
