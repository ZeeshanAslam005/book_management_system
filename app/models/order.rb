class Order < ActiveRecord::Base
  belongs_to :user
  belongs_to :book

  validates :quantity, presence: true, numericality: { greater_than: 0 }
  validates :total_price, presence: true, numericality: { greater_than_or_equal_to: 0 }

  before_validation :calculate_total_price

  scope :total_revenue, -> { sum(:total_price) }

  scope :monthly_revenue, -> {
    select("DATE_TRUNC('month', created_at) AS month, SUM(total_price) AS total_revenue")
      .group("DATE_TRUNC('month', created_at)")
      .order("month ASC")
  }                       

  private

  def calculate_total_price
    return unless book.present? && quantity.present?

    self.total_price = book.price * quantity
  end
end
