module ControllerSpecHelper
  # generate tokens from user id
  def token_generator(user_id)
    JsonWebToken.encode(user_id: user_id)
  end

  # generate expired tokens from user id
  def expired_token_generator(user_id)
    JsonWebToken.encode({ user_id: user_id }, (Time.now.to_i - 10))
  end

  # return auth valid headers
  def auth_valid_headers(admin_user)
    {
      "Accept" => "application/base-api.v1+json",
      "Content-Type" => "application/json",
      "ApiToken" => admin_user.api_token
    }
  end
  # return valid headers
  def valid_headers(user)
    {
      "Accept" => "application/base-api.v1+json",
      "Authorization" => token_generator(user.id),
      "Content-Type" => "application/json"
    }
  end

  # return invalid headers
  def invalid_headers
    {
      "Authorization" => nil,
      "Content-Type" => "application/json"
    }
  end
end