require 'rails_helper'

RSpec.describe 'Sessions', type: :request do
  let!(:user) { User.create(email: 'user@example.com', password: 'password') }
  let!(:authentication_token) do
    AuthenticationToken.create(user_id: user.id,
                               body: 'token', last_used_at: DateTime.current)
  end

  let(:valid_session) do
    { 'HTTP_X_USER_EMAIL' => user.email,
      'HTTP_X_AUTH_TOKEN' => authentication_token.body }
  end

  describe 'POST /sessions' do
    it 'logs in the user' do
      post sessions_path, user: { email: user.email, password: 'password' }, format: :json
      expect(response).to have_http_status(200)
    end
  end

  describe 'DELETE /sessions' do
    it 'logs out the user' do
      delete sessions_path, { format: :json }, valid_session
      expect(response).to have_http_status(200)
    end
  end
end
