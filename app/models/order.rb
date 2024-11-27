class Order < ActiveRecord::Base
  belongs_to :user
  belongs_to :book

  validates :quantity, presence: true, numericality: { greater_than: 0 }
  validates :total_price, presence: true, numericality: { greater_than_or_equal_to: 0 }

  before_validation :calculate_total_price

  private

  def calculate_total_price
    if book.present? && quantity.present?
      self.total_price = book.price * quantity
    end
  end
end
