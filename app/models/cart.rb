class Cart
  attr_reader :data

  def initialize(data)
    @data = data || {}
  end

  def items
    @data.map do |project_id, funding_amount|
      project = Project.find(project_id)
      CartItem.new(project, funding_amount)
    end
  end

  def update_funding_amount(project_id, funding_amount)
    data[project_id] = funding_amount.to_i
  end

  def add_project(project)
    data[project.id.to_s] ||= 0
  end

  def remove_project(project)
    data.except!(project.id.to_s)
  end
end
