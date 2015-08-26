class Project < ActiveRecord::Base
  belongs_to :company

  validates :description,
            :current_funding,
            :funding_goal,
            :end_date,
            :name,
            :image,
            :company_id, presence: true
  validates :name, :image, :company_id, uniqueness: true
end
