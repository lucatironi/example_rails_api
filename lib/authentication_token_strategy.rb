class AuthenticationTokenStrategy < ::Warden::Strategies::Base

  def valid?
    user_email_from_headers.present? && auth_token_from_headers.present?
  end

  def authenticate!
    failure_message = "Authentication failed for user/token"

    user = User.find_by(email: user_email_from_headers)
    return fail!(failure_message) unless user

    token = TokenIssuer.build.find_token(user, auth_token_from_headers)
    if token
      touch_token(token)
      return success!(user)
    end

    fail!(failure_message)
  end

  def store?
    false
  end

  private

    def user_email_from_headers
      env["HTTP_X_USER_EMAIL"]
    end

    def auth_token_from_headers
      env["HTTP_X_AUTH_TOKEN"]
    end

    def touch_token(token)
      token.update_attribute(:last_used_at, DateTime.current) if token.last_used_at < 1.hour.ago
    end

end
