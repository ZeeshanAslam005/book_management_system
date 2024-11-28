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
    if !current_user.managed_bookstores.exists?(@book.bookstore_id)
      redirect_to books_path, alert: "You can only add books to your assigned bookstores."
    elsif @book.save
      redirect_to books_path, notice: 'Book was successfully created.'
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
    params.require(:book).permit(:title, :author, :price, :bookstore_id, :manager_id, :published_date)
  end

  def authorize_book_creation
    unless current_user.admin? || current_user.manager?
      redirect_to books_path, alert: 'You are not authorized to create books.'
    end
  end

  def verify_admin_or_manager
    redirect_to root_path, alert: 'Access Denied' unless current_user.admin? || current_user.manager?
  end
end
