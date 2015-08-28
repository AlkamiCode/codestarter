class User < ActiveRecord::Base
  has_many :orders
  has_secure_password
  validates :username, presence: true, uniqueness: true, length: { in: 5..12 }
  validates :password, presence: true, length: { in: 5..12 }, confirmation: true
  validates :url, presence: true, uniqueness: true
  has_one :address

  enum role: %w(default admin)

  before_validation :generate_url

  def generate_url
    self.url = username.parameterize
  end

  def to_param
    "dashboard"
  end
end
