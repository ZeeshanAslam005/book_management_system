class User < ActiveRecord::Base
  has_many :orders, dependent: :destroy

  before_create :generate_authentication_token

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: JwtDenylist


  ROLES = %w[admin manager customer].freeze

  validates :role, inclusion: { in: ROLES }

  def admin?
    role == 'admin'
  end

  def manager?
    role == 'manager'
  end

  def customer?
    role == 'customer'
  end

  private

  def generate_authentication_token
    self.authentication_token = SecureRandom.hex(20)
  end
end

