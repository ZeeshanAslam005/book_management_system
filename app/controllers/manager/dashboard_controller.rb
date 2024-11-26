class Manager::DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :verify_manager

  def index
    @bookstores = Bookstore.where(manager_id: current_user.id)
    @total_sales = @bookstores.joins(:orders).sum('orders.total_price')
  end

  private

  def verify_manager
    redirect_to root_path, alert: 'Access Denied' unless current_user.manager?
  end
end
