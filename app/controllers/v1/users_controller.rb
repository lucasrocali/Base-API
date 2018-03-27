class V1::UsersController < ApplicationController
  skip_before_action :authorize_request, only: [:signup]
  
  def signup
    @user = User.new(user_params)
    @user.save!
    @user = AuthenticateUser.new(params[:email], params[:password], false).call
    render json: @user
  end

  private

  def user_params
    params.permit(
      :name,
      :email,
      :password,
      :password_confirmation,
      :login_type
    )

  end

end