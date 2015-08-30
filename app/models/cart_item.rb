class CartItem < SimpleDelegator
  attr_accessor :funding_amount

  def initialize(project, funding_amount = 0)
    super(project)
    @funding_amount = funding_amount
  end

  def self.funding_amounts
    [100, 200, 500, 1000, 1500, 2000, 2500, 3000]
  end
end
