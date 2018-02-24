class V1::AuthenticationController < ApplicationController
  skip_before_action :authorize_request, only: :authenticate
  
  # return auth token once user is authenticated
  def authenticate
    user =
    AuthenticateUser.new(auth_params[:email], auth_params[:password], true).call

    render json: user
  end

  private

  def auth_params
    params.permit(:name, :email, :password)
  end
end
