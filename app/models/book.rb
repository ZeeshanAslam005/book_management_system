class Book < ActiveRecord::Base
  belongs_to :bookstore

  validates :title, :author, :price, presence: true
end
