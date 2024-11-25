class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
      :recoverable, :rememberable, :validatable,
      :two_factor_authenticatable, # MFA
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
end
