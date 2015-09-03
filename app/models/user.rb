class User < ActiveRecord::Base
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  has_many :orders
  has_many :user_roles
  has_many :roles, through: :user_roles
  belongs_to :company

  has_secure_password

  validates :username, presence: true, uniqueness: true, length: { in: 2..25 }
  validates :password, presence: true, length: { in: 5..25 }, confirmation: true
  validates :email, uniqueness: true, presence: true,
                    format: { with: VALID_EMAIL_REGEX },
                    length: { maximum: 50 }

  def company_admin?
    roles.exists?(name: 'company_admin')
  end

  def registered_user?
    roles.exists?(name: 'registered_user')
  end

  def collaborator?
    roles.exists?(name: 'collaborator')
  end

  def former_collaborator?
    roles.exists?(name: 'former_collaborator')
  end
end
