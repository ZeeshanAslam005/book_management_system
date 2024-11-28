module API
  class Base < Grape::API
    content_type :json, 'application/json'
    default_format :json
    format :json  
    prefix :api

    mount V1::Root

    add_swagger_documentation
  end
end
