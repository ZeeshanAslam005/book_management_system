class User < ActiveRecord::Base
  belongs_to :manager, class_name: "User", optional: true

  def managed_by?(user)
    manager_id == user.id
  end
end