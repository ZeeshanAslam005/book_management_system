require_relative './index'
require_relative './show'

module API
  module V1
    module Books
      class Base < Grape::API
        namespace :books do
          before { current_user }
          
          mount API::V1::Books::Index
          mount API::V1::Books::Show
        end
      end
    end
  end
end
