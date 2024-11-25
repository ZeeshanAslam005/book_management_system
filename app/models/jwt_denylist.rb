class JwtDenylist < ActiveRecord::Base
  include Devise::JWT::RevocationStrategies::Denylist
end
