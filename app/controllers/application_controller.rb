class ApplicationController < ActionController::Base
  include Pundit::Authorization

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  before_action :authenticate_user!

  def after_sign_in_path_for(resource)
    case resource.role
    when 'admin'
      admin_dashboard_index_path
    when 'manager'
      manager_dashboard_index_path
    when 'customer'
      customer_dashboard_index_path
    else
      root_path
    end
  end

  private

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(request.referrer || root_path)
  end
end
