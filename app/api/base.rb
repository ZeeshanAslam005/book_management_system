module API
  class Base < Grape::API
    format :json
    prefix :api

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

    mount API::V1::Auth
    mount API::V1::BookStore
    mount API::V1::Books

    add_swagger_documentation
  end
end
