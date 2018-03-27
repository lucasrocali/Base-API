class User < ApplicationRecord
  
  enum login_type: [:Manual, :Facebook, :Google]

  attr_accessor :auth_token
  has_secure_password

  validates_presence_of :email, :password_digest
  validates_uniqueness_of :email

  before_validation :handle_social_login

  def handle_social_login
    if social_login
      self.password = self.social_id
    else
      self.login_type = "Manual"
    end
  end

  def social_login
    if login_type == "Facebook" || login_type == "Google"
      return true
    end
    return false
  end
end
