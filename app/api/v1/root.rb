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

      helpers Pundit

      # Rescue ActiveRecord::RecordNotFound globally for this endpoint
      rescue_from ActiveRecord::RecordNotFound do |e|
        error!({ error: 'not found', message: e.message }, 404)
      end
      
      helpers do
        def current_user
          auth_header = headers['Authorization']
          token = auth_header&.split(' ')&.last
          payload = Warden::JWTAuth::TokenDecoder.new.call(token)
          User.find(payload['sub'])
        rescue StandardError
          error!({ error: 'Unauthorized access' }, 401)
        end

        def authorize!(record, query)
          policy = Pundit.policy(current_user, record)
          unless policy.public_send(query)
            error!('403 Forbidden: You are not authorized to perform this action', 403)
          end
        end

        # Policy scope implementation for Grape
        def policy_scope(scope)
          Pundit.policy_scope!(current_user, scope)
        end
      end

      mount V1::Auth
      mount V1::BookStores::Base
      mount V1::Books::Base
    end
  end
end
