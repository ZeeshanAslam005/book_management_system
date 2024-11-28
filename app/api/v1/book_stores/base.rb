require_relative './index'
require_relative './show'

module API
  module V1
    module BookStores
      class Base < Grape::API
        namespace :book_stores do
          before { current_user }
          
          mount API::V1::BookStores::Index
          mount API::V1::BookStores::Show
        end
      end
    end
  end
end
