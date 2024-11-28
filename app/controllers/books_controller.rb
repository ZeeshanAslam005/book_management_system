class BooksController < ApplicationController
  before_action :authenticate_user!

  def index
    @q = policy_scope(Book).ransack(params[:q])
    @books = @q.result.includes(:bookstore).page(params[:page]).per(10)
  end
end
