class AdminUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :trackable, :validatable

  validates_uniqueness_of :api_token

  before_validation(on: :create) do
    self.api_token = Devise.friendly_token(20)
  end

end
