class V1::AuthenticationController < ApplicationController
  skip_before_action :authorize_request, only: :authenticate
  
  # return auth token once user is authenticated
  def authenticate

    if User.find_by(email: auth_params[:email]).nil? && automatic_login(auth_params[:login_type])
      user = User.new(auth_params)
      user.save!
    end

    user =
    AuthenticateUser.new(auth_params[:email], auth_params[:password], true).call

    render json: user
  end

  def automatic_login(login_type) 
    if login_type == "Facebook" || login_type == "Google"
      return true
    end
    return false
  end

  private

  def auth_params
    params.permit(:name, :email, :password, :login_type, :img_url, :social_id)
  end
end
