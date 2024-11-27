module API
  class Base < Grape::API
    format :json
    prefix :api

    mount API::V1::Auth

    add_swagger_documentation
  end
end
