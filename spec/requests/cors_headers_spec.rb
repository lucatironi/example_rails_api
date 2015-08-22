require 'rails_helper'

RSpec.describe "CORS headers", type: :request do

  describe "OPTIONS /*" do
    it "returns the CORS headers" do
      reset!
      integration_session.__send__ :process, 'OPTIONS', '/test'

      expect(response).to have_http_status(204)
      expect(response.body).to be_blank

      expect(response.headers['Access-Control-Allow-Origin']).to eq('*')

      %w{GET POST PUT DELETE}.each do |method|
        expect(response.headers['Access-Control-Allow-Methods']).to include(method)
      end

      %w{Content-Type Accept X-User-Email X-Auth-Token}.each do |header|
        expect(response.headers['Access-Control-Allow-Headers']).to include(header)
      end
    end
  end

end
