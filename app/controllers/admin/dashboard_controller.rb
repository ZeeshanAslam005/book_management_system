class Admin::DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :verify_admin

  def index
    @total_bookstores = Bookstore.count
    @total_books = Book.count
    @total_revenue = Order.sum(:total_price)

    @monthly_revenue = Order.select("DATE_TRUNC('month', created_at) AS month, SUM(total_price) AS total_revenue")
                          .group("DATE_TRUNC('month', created_at)")
                          .order("month ASC")
                          .map { |record| [record.month.strftime("%B %Y"), record.total_revenue] }
                          .to_h

    @best_performing_bookstores = Bookstore.joins(:orders)
                                           .group('bookstores.id', 'bookstores.name')
                                           .sum('orders.total_price')
                                           .sort_by { |_id, revenue| -revenue }
                                           .first(5)
  end

  private

  def verify_admin
    redirect_to root_path, alert: 'Access Denied' unless current_user.admin?
  end
end
