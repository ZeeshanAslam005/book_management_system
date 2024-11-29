class Admin::ManagersController < ApplicationController
  before_action :authenticate_user!
  before_action :verify_admin

  def index
    @managers = User.managers.includes(:managed_bookstores)
  end

  def new
    @manager = User.new(role: 'manager')
  end

  def create
    @manager = User.new(manager_params)
    @manager.role = 'manager'

    if @manager.save
      redirect_to admin_managers_path, notice: 'Manager created successfully.'
    else
      render :new
    end
  end

  def edit
    @manager = User.find(params[:id])
  end

  def update
    @manager = User.find(params[:id])

    if @manager.update(manager_params)
      redirect_to admin_managers_path, notice: 'Manager updated successfully.'
    else
      render :edit
    end
  end

  def destroy
    @manager = User.find(params[:id])
    @manager.destroy
    redirect_to admin_managers_path, notice: 'Manager deleted successfully.'
  end

  private

  def manager_params
    params.require(:user).permit(:email, :password, :password_confirmation, bookstore_ids: [])
  end

  def verify_admin
    redirect_to root_path, alert: 'Access Denied' unless current_user.admin?
  end
end