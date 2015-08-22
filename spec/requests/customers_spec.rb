require 'rails_helper'

RSpec.describe "Customers", type: :request do

  let!(:user) { User.create(email: "user@example.com", password: "password") }
  let!(:authentication_token) { AuthenticationToken.create(user_id: user.id,
      body: "token", last_used_at: DateTime.current) }
  let!(:customer) { Customer.create(full_name: "John Doe", email: "john.doe@example.com") }

  let(:valid_session) {
    { "HTTP_X_USER_EMAIL" => user.email,
      "HTTP_X_AUTH_TOKEN" => authentication_token.body } }

  describe "GET /customers" do
    it "lists all the customers" do
      get customers_path, { format: :json }, valid_session
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /customers/:id" do
    it "gets a single customer" do
      get customer_path(customer), { format: :json }, valid_session
      expect(response).to have_http_status(200)
    end
  end

  describe "POST /customers" do
    it "creates a new customer" do
      post customers_path,
        { customer: { full_name: "John Doe", email: "john.doe@example.com" },
        format: :json }, valid_session
      expect(response).to have_http_status(201)
    end
  end

  describe "PUT /customers/:id" do
    it "updates a customer" do
      put customer_path(customer),
        { customer: { full_name: "John F. Doe" }, format: :json },
        valid_session
      expect(response).to have_http_status(204)
    end
  end

  describe "DELETE /customers/:id" do
    it "logs out the user" do
      delete customer_path(customer), { format: :json }, valid_session
      expect(response).to have_http_status(204)
    end
  end

end
