class Book < ActiveRecord::Base  
  belongs_to :bookstore
  belongs_to :manager, class_name: 'User', required: false

  has_many :orders, dependent: :destroy

  validates :title, :author, :price, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }

  ransacker :formatted_price do
    Arel.sql("CAST(price AS CHAR)")
  end
end
