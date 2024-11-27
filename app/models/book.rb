class Book < ActiveRecord::Base  
  belongs_to :bookstore

  validates :title, :author, :price, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }
end
