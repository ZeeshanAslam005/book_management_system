class Admin::DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :verify_admin

  def index
    dashboard = DashboardService.new
    @total_bookstores = dashboard.total_bookstores
    @total_books = dashboard.total_books
    @total_revenue = dashboard.total_revenue
    @monthly_revenue = dashboard.monthly_revenue
    @best_performing_bookstores = dashboard.best_performing_bookstores
  end

  private

  def verify_admin
    redirect_to root_path, alert: 'Access Denied' unless current_user.admin?
  end
end
