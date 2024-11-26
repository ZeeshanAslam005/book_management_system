class Book < ActiveRecord::Base
  include Swagger::Docs::Methods
  
  swagger_model :Book do
    property :id, :integer, :required, "Book ID"
    property :title, :string, :required, "Book Title"
    property :author, :string, :required, "Book Author"
    property :price, :float, :required, "Book Price"
    property :bookstore_id, :integer, :required, "Associated Bookstore ID"
  end
  
  belongs_to :bookstore

  validates :title, :author, :price, presence: true
end
