class Manager::DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :verify_manager

  def index
    @bookstores = Bookstore.managed_by(current_user)
    @total_sales = @bookstores.total_sales
  end

  private

  def verify_manager
    redirect_to root_path, alert: 'Access Denied' unless current_user.manager?
  end
end
