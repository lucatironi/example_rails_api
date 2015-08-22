class AuthenticationToken < ActiveRecord::Base
  belongs_to :user
  has_secure_token :body
end
