class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  attr_accessor :auth_token
  has_secure_password

  validates_presence_of :email, :password_digest
  validates_uniqueness_of :email
end
