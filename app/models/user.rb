class User < ActiveRecord::Base
  has_many :orders, dependent: :destroy
  has_many :managed_bookstores, class_name: 'Bookstore', foreign_key: 'manager_id', dependent: :nullify
  has_many :books, foreign_key: 'manager_id', dependent: :nullify

  before_create :generate_authentication_token

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: JwtDenylist

  scope :managers, -> { where(role: 'manager') }
  scope :admins, -> { where(role: 'admin') }
  scope :customers, -> { where(role: 'customer') }
  scope :managers_and_customers, -> { where(role: %w[manager customer]) }
  scope :with_managed_bookstores, -> { includes(:managed_bookstores) }
  
  ROLES = %w[admin manager customer].freeze

  validates :role, inclusion: { in: ROLES }
  validates :email, presence: true, uniqueness: true

  def bookstore_ids
    managed_bookstores.pluck(:id)
  end

  def bookstore_ids=(ids)
    self.managed_bookstores = Bookstore.where(id: ids.reject(&:blank?))
  end

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
