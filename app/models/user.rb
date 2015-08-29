class User < ActiveRecord::Base
  has_many :orders
  has_secure_password
  validates :username, presence: true, uniqueness: true, length: { in: 5..12 }
  validates :password, presence: true, length: { in: 5..12 }, confirmation: true
  has_one :address

  enum role: %w(default admin)

  def to_param
    "dashboard"
  end
end
