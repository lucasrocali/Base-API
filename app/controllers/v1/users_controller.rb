class V1::UsersController < ApplicationController
  skip_before_action :authorize_request, only: [:signup]
  
  def signup
    @user = User.new(user_params)
    @user.save!
    @user = AuthenticateUser.new(params[:email], params[:password], false).call
    render json: @user
  end

  def change_password
    # puts current_user.password
    # puts params[:old_password]
    if (current_user.authenticate(params[:old_password]))

      current_user.password = params[:password]
      current_user.password_confirmation = params[:password_confirmation]

      current_user.save!

      new_current_user = AuthenticateUser.new(current_user.email, current_user.password, true).call

      render json: new_current_user
    else
      raise(ExceptionHandler::AuthenticationError, Message.login_invalid_password)
    end
    
  end

  def change_info
    if (params[:name].nil?)
       raise(ExceptionHandler::AuthenticationError, Message.login_invalid_info)
    else
      current_user.name = params[:name]
      
      current_user.save!

      new_current_user = AuthenticateUser.new(current_user.email, current_user.password, true, true).call

      render json: new_current_user
    end
    

  end

  private

  def user_params
    params.permit(
      :name,
      :email,
      :password,
      :password_confirmation,
      :login_type,
      :old_password
    )

  end

end