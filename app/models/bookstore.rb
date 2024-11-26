class Bookstore < ActiveRecord::Base
  audited

  swagger_model :Bookstore do
    property :id, :integer, :required, "Bookstore ID"
    property :name, :string, :required, "Bookstore Name"
    property :location, :string, :optional, "Bookstore Location"
  end

  belongs_to :manager, class_name: "User"
  
  has_many :books, dependent: :destroy
  
  validates :manager, presence: false
  validates :name, presence: true

  def managed_by?(user)
    manager_id == user.id
  end
end
