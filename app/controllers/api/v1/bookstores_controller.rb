class Api::V1::BookstoresController < Api::V1::BaseController
  swagger_controller :bookstores, "Bookstore Management"

  swagger_api :index do
    summary "Fetches all bookstores"
    response :ok, "Success", :Bookstore
    response :unauthorized
  end

  swagger_api :show do
    summary "Fetches a specific bookstore"
    param :path, :id, :integer, :required, "Bookstore ID"
    response :ok, "Success", :Bookstore
    response :not_found
  end

  def index
    bookstores = Bookstore.page(params[:page]).per(params[:per_page])
    render json: bookstores
  end

  def show
    bookstore = Bookstore.find_by(id: params[:id])
    if bookstore
      render json: bookstore
    else
      render json: { error: "Bookstore not found" }, status: :not_found
    end
  end
end
