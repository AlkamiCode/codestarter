class Project < ActiveRecord::Base
  belongs_to :company

  validates :description,
            :current_funding,
            :funding_goal,
            :end_date,
            :name,
            :image, presence: true

  def funding_in_percentage
    if current_funding > funding_goal
      100
    else
      ((current_funding.to_f / funding_goal.to_f) * 100).to_i
    end
  end

  def pretty_end_date
    end_date.strftime("%B %d, %Y")
  end

  def random_projects
    Project.all.shuffle[0..3]
  end
end
