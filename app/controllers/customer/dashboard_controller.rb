class Customer::DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :verify_customer

  def index
    @orders = current_user.orders.includes(:books)
  end

  private

  def verify_customer
    redirect_to root_path, alert: 'Access Denied' unless current_user.customer?
  end
end
