require 'rails_helper'

RSpec.describe "Data", type: :request do
  describe "GET /data" do
    it "works! (now write some real specs)" do
      get data_path
      expect(response).to have_http_status(200)
    end
  end
end
