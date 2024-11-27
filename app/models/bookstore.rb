class Bookstore < ActiveRecord::Base
  audited

  belongs_to :manager, class_name: "User"
  
  has_many :books, dependent: :destroy
  has_many :orders, through: :books
  
  validates :manager, presence: false
  validates :name, presence: true

  def managed_by?(user)
    manager_id == user.id
  end
end
