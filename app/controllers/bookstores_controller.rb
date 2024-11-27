class BookstoresController < ApplicationController
  before_action :authenticate_user!

  def index
    @q = Bookstore.ransack(params[:q])
    @bookstores = @q.result.page(params[:page]).per(10)
  end
end
