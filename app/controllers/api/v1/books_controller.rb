class Api::V1::BooksController < Api::V1::BaseController
  swagger_controller :books, "Book Management"

  swagger_api :index do
    summary "Fetches all books"
    param :query, :bookstore_id, :integer, :optional, "Filter by Bookstore ID"
    response :ok, "Success", :Book
  end

  swagger_api :show do
    summary "Fetches a specific book"
    param :path, :id, :integer, :required, "Book ID"
    response :ok, "Success", :Book
    response :not_found
  end

  def index
    books = if params[:bookstore_id]
              Book.where(bookstore_id: params[:bookstore_id]).page(params[:page]).per(params[:per_page])
            else
              Book.page(params[:page]).per(params[:per_page])
            end
    render json: books
  end

  def show
    book = Book.find_by(id: params[:id])
    if book
      render json: book
    else
      render json: { error: "Book not found" }, status: :not_found
    end
  end
end
