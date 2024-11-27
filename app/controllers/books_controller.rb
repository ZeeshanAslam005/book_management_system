class BooksController < ApplicationController
  before_action :authenticate_user!

  def index
    @q = Book.ransack(params[:q])
    @books = @q.result.includes(:bookstore).page(params[:page]).per(10)
  end
end