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

  def funding_in_percentage
    (current_funding.to_f / funding_goal.to_f) * 100
  end

  def pretty_end_date
    end_date.strftime("%B %d, %Y")
  end
end
