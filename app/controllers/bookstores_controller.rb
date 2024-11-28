class BookstoresController < ApplicationController
  before_action :authenticate_user!
  before_action :verify_admin, except: [:index, :show]

  def index
    @q = policy_scope(Bookstore).ransack(params[:q])
    @bookstores = @q.result.page(params[:page]).per(10)
  end

  def show
    @bookstore = Bookstore.find(params[:id])
    @books = @bookstore.books
  end

  def new
    @bookstore = Bookstore.new
  end

  def create
    @bookstore = Bookstore.new(bookstore_params)
    if @bookstore.save
      redirect_to @bookstore, notice: 'Bookstore created successfully.'
    else
      render :new
    end
  end

  def edit
    @bookstore = Bookstore.find(params[:id])
  end

  def update
    @bookstore = Bookstore.find(params[:id])
    if @bookstore.update(bookstore_params)
      redirect_to @bookstore, notice: 'Bookstore updated successfully.'
    else
      render :edit
    end
  end

  def destroy
    @bookstore = Bookstore.find(params[:id])
    @bookstore.destroy
    redirect_to bookstores_path, notice: 'Bookstore deleted successfully.'
  end

  private

  def bookstore_params
    params.require(:bookstore).permit(:name, :location, :manager_id)
  end

  def verify_admin
    redirect_to root_path, alert: 'Access Denied' unless current_user.admin?
  end
end

