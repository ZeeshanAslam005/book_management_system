class Admin::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :verify_admin

  def index
    @users = User.managers_and_customers.with_managed_bookstores
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to admin_users_path, notice: "#{@user.role.capitalize} created successfully."
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      redirect_to admin_users_path, notice: "#{@user.role.capitalize} updated successfully."
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_path, notice: "#{@user.role.capitalize} deleted successfully."
  end

  private

  def user_params
    params.require(:user).permit(
      :email,
      :password,
      :password_confirmation,
      :role,
      bookstore_ids: []
    )
  end

  def verify_admin
    redirect_to root_path, alert: 'Access Denied' unless current_user.admin?
  end
end
