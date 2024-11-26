class Bookstore < ActiveRecord::Base
  audited

  belongs_to :manager, class_name: "User"
  validates :manager, presence: false

  def managed_by?(user)
    manager_id == user.id
  end
end