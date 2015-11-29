require 'rails_helper'

RSpec.describe 'CORS', type: :request do
  before { head '/something' }

  it 'respond with 204 and CORS headers' do
    expect(response.status).to eq(204)
    expect(response.body).to be_blank
  end

  it 'returns the Access-Control-Allow-Origin header to allow CORS from anywhere' do
    expect(response.headers['Access-Control-Allow-Origin']).to eq('*')
  end

  it 'returns general HTTP methods through CORS (GET/POST/PUT/DELETE)' do
    %w(GET POST PUT DELETE).each do |method|
      expect(response.headers['Access-Control-Allow-Methods']).to include(method)
    end
  end

  it 'returns the allowed headers' do
    %w(Content-Type Accept X-User-Email X-Auth-Token).each do |header|
      expect(response.headers['Access-Control-Allow-Headers']).to include(header)
    end
  end
end
