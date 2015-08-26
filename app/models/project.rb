class Project < ActiveRecord::Base
  belongs_to :company

  validates :description,
            :current_funding,
            :funding_goal,
            :end_date,
            :name,
            :image,
            :company_id, presence: true
  validates :name, uniqueness: true

  def funding_in_percentage
    current_funding > funding_goal ?
                               100 :
                               (current_funding.to_f / funding_goal.to_f) * 100
  end

  def pretty_end_date
    end_date.strftime("%B %d, %Y")
  end

  def random_projects
    Project.all.shuffle[0..3]
  end
end
