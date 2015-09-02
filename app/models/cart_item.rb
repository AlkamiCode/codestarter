class CartItem < SimpleDelegator
  attr_accessor :funding_amount

  def initialize(project, funding_amount = 0)
    super(project)
    @funding_amount = funding_amount
  end
end
