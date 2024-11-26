class Api::V1::BaseController < ActionController::API
  before_action :authenticate_token!

  private

  def authenticate_token!
    token = request.headers["Authorization"]
    user = User.find_by(authentication_token: token)
    render json: { error: "Unauthorized" }, status: :unauthorized unless user
    @current_user = user
  end

  def current_user
    @current_user
  end
end
