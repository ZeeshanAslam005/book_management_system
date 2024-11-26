class Bookstore < ActiveRecord::Base
  include Swagger::Docs::Methods
  audited

  swagger_model :Bookstore do
    description "A Bookstore entity"
    property :id, :integer, :required, "Bookstore ID"
    property :name, :string, :required, "Bookstore Name"
    property :location, :string, :optional, "Bookstore Location"
    property :manager_id, :integer, :optional, "ID of the manager"
  end

  belongs_to :manager, class_name: "User"
  
  has_many :books, dependent: :destroy
  
  validates :manager, presence: false
  validates :name, presence: true

  def managed_by?(user)
    manager_id == user.id
  end
end
