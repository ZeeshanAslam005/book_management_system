class Admin::DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :verify_admin

  def index
    @metrics = {
      total_bookstores: Bookstore.count,
      total_books: Book.count,
      total_revenue: Order.sum(:total_price)
    }
  end

  private

  def verify_admin
    redirect_to root_path, alert: "Access Denied" unless current_user.admin?
  end
end
