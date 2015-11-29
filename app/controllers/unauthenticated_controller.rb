class UnauthenticatedController < ActionController::Metal
  def self.call(env)
    @respond ||= action(:respond)
    @respond.call(env)
  end

  def respond
    self.status        = :unauthorized
    self.content_type  = 'application/json'
    self.response_body = { errors: ['Unauthorized Request'] }.to_json
    headers['Access-Control-Allow-Origin']  = CORS_ALLOW_ORIGIN
    headers['Access-Control-Allow-Methods'] = CORS_ALLOW_METHODS
    headers['Access-Control-Allow-Headers'] = CORS_ALLOW_HEADERS
  end
end
