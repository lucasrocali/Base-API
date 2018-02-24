class AuthenticateUser
  def initialize(email, password, login)
    @email = email
    @password = password
    @login = login
  end

  # Service entry point
  def call
    return user
      
    # end
    # return
  end

  private

  attr_reader :email, :password

  # verify user credentials
  def user
    user = User.find_by(email: email)
    # puts 'PASS'
    # puts user.to_json
    if user 
      if user.authenticate(@password)
        
        user.auth_token = JsonWebToken.encode(user_id: user.id)
        return user 
      elsif @login
        raise(ExceptionHandler::AuthenticationError, Message.login_invalid_password)
      end
    elsif @login && @email
      raise(ExceptionHandler::AuthenticationError, Message.login_user_not_found)
    end
    
    raise(ExceptionHandler::AuthenticationError, Message.invalid_credentials)
  end
end