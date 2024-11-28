require 'grape-swagger'
require_relative './auth'
require_relative './book_stores/base'
require_relative './books/base'

module API
  module V1
    class Root < Grape::API
      content_type :json, 'application/json'
      default_format :json
      format :json
      prefix :v1

      helpers do
        def current_user
          auth_header = headers['Authorization']
          token = auth_header&.split(' ')&.last
          payload = Warden::JWTAuth::TokenDecoder.new.call(token)
          User.find(payload['sub'])
        rescue StandardError
          error!({ error: 'Unauthorized access' }, 401)
        end
      end

      mount V1::Auth
      mount V1::BookStores::Base
      mount V1::Books::Base
    end
  end
end
