class TokenIssuer
  MAXIMUM_TOKENS_PER_USER = 20

  def self.build
    new(MAXIMUM_TOKENS_PER_USER)
  end

  def self.create_and_return_token(resource, request)
    build.create_and_return_token(resource, request)
  end

  def self.expire_token(resource, request)
    build.expire_token(resource, request)
  end

  def self.purge_old_tokens(resource)
    build.purge_old_tokens(resource)
  end

  def initialize(maximum_tokens_per_user)
    self.maximum_tokens_per_user = maximum_tokens_per_user
  end

  def create_and_return_token(resource, request)
    token = resource.authentication_tokens.create!(
      last_used_at: DateTime.current,
      ip_address:   request.remote_ip,
      user_agent:   request.user_agent)

    token.body
  end

  def expire_token(resource, request)
    find_token(resource, request.headers["X-Auth-Token"]).try(:destroy)
  end

  def find_token(resource, token_from_headers)
    resource.authentication_tokens.detect do |token|
      token.body == token_from_headers
    end
  end

  def purge_old_tokens(resource)
    resource.authentication_tokens
      .order(last_used_at: :desc)
      .offset(maximum_tokens_per_user)
      .destroy_all
  end

  private

    attr_accessor :maximum_tokens_per_user

end
