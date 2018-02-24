class V1::UsersController < ApplicationController
  skip_before_action :authorize_request, only: [:signup]
  
	def signup
    api_token = request.headers["ApiToken"]
    adminUser = AdminUser.where(api_token: api_token).first

    if !adminUser.nil?

      @user = User.new(user_params)
      @user.save!
      @user = AuthenticateUser.new(params[:email], params[:password], false).call
      render json: @user
    else
      json_response({ message: Message.invalid_api_token }, 422)
    end
  end

  private

  def user_params
    params.permit(
      :name,
      :email,
      :password,
      :password_confirmation
    )

  end

end