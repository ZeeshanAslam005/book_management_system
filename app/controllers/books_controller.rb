class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :verify_admin_or_manager, except: [:index, :show]

  def index
    @q = policy_scope(Book).ransack(params[:q])
    @books = @q.result.includes(:bookstore).page(params[:page]).per(10)
  end

  def show
    @book = Book.find(params[:id])
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      redirect_to @book, notice: 'Book created successfully.'
    else
      render :new
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to @book, notice: 'Book updated successfully.'
    else
      render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path, notice: 'Book deleted successfully.'
  end

  private

  def book_params
    params.require(:book).permit(:title, :author, :price, :bookstore_id, :manager_id)
  end

  def verify_admin_or_manager
    redirect_to root_path, alert: 'Access Denied' unless current_user.admin? || current_user.manager?
  end
end
