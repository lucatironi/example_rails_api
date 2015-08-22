require 'rails_helper'

RSpec.describe SessionsController, type: :controller do

  let!(:user) { User.create(email: "user@example.com", password: "password") }
  let!(:authentication_token) { AuthenticationToken.create(user_id: user.id,
      body: "token", last_used_at: DateTime.current) }

  let(:valid_attributes) {
    { user: { email: user.email, password: "password" } }
  }

  let(:invalid_attributes) {
    { user: { email: user.email, password: "not-the-right-password" } }
  }

  let(:parsed_response) { JSON.parse(response.body) }

  def set_auth_headers
    request.env["HTTP_X_USER_EMAIL"] = user.email
    request.env["HTTP_X_AUTH_TOKEN"] = authentication_token.body
  end

  before do
    allow(TokenIssuer).to receive(:create_and_return_token).and_return(authentication_token.body)
  end

  describe "POST #create" do
    context "with valid credentials" do
      before { post :create, valid_attributes, format: :json  }

      it { expect(response).to be_success }
      it { expect(parsed_response).to eq({ "user_email" => user.email, "auth_token" => authentication_token.body }) }
    end

    context "with invalid credentials" do
      before { post :create, invalid_attributes, format: :json }

      it { expect(response.status).to eq(401) }
    end

    context "with missing/invalid params" do
      before { post :create, { foo: { bar: "baz" }, format: :json } }

      it { expect(response.status).to eq(422) }
    end
  end

  describe "DELETE #destroy" do
    context "with valid credentials" do
      before do
        set_auth_headers
        delete :destroy, { format: :json }
      end

      it { expect(response).to be_success }
    end

    context "with invalid credentials" do
      before { delete :destroy, { format: :json } }

      it { expect(response.status).to eq(401) }
    end
  end

end
