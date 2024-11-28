class Bookstore < ActiveRecord::Base
  audited

  belongs_to :manager, class_name: "User"
  
  has_many :books, dependent: :destroy
  has_many :orders, through: :books
  
  validates :manager, presence: false
  validates :name, presence: true

  scope :best_performing, ->(limit = 5) {
    joins(:orders)
      .group('bookstores.id', 'bookstores.name')
      .sum('orders.total_price')
      .sort_by { |_id, revenue| -revenue }
      .first(limit)
  }

  def managed_by?(user)
    manager_id == user.id
  end
end
