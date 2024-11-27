module API
  module V1
    class Auth < Grape::API
      format :json

      resource :auth do
        desc 'User Login'
        params do
          requires :email, type: String, desc: 'User email'
          requires :password, type: String, desc: 'User password'
        end
        post :login do
          user = User.find_by(email: params[:email])
          if user&.valid_password?(params[:password])
            token = Warden::JWTAuth::UserEncoder.new.call(user, :user, nil).first
            {
              token: token,
              message: 'Logged in successfully'
            }
          else
            error!({ error: 'Invalid email or password' }, 401)
          end
        end

        desc 'User Logout'
        delete :logout do
          auth_header = headers['Authorization']
          token = auth_header.split(' ').last if auth_header
          payload = Warden::JWTAuth::TokenDecoder.new.call(token)
          JwtDenylist.create!(jti: payload['jti'], exp: Time.at(payload['exp']))
          {
            message: 'Logged out successfully'
          }
        end
      end
    end
  end
end
