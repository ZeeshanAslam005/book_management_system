class DashboardService
  def initialize
    @bookstore_model = Bookstore
    @order_model = Order
  end

  def total_bookstores
    @bookstore_model.count
  end

  def total_books
    Book.count
  end

  def total_revenue
    @order_model.total_revenue
  end

  def monthly_revenue
    @order_model.monthly_revenue.map { |record| [record.month.strftime("%B %Y"), record.total_revenue] }
    .to_h
  end

  def best_performing_bookstores(limit = 5)
    @bookstore_model.best_performing(limit)
  end
end
