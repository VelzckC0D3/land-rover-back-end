require 'rails_helper'

RSpec.describe Api::V1::CarsController, type: :controller do
  describe 'GET #index' do
    it 'returns a not_found response when no cars are available' do
      get :index
      expect(response).to have_http_status(:not_found)
      expect(JSON.parse(response.body)['message']).to eq('No Cars Found')
    end

    it 'returns an internal_server_error response on exception' do
      allow(Car).to receive(:all).and_raise(StandardError.new('Test Error'))
      get :index
      expect(response).to have_http_status(:internal_server_error)
      expect(JSON.parse(response.body)['error']).to eq('Test Error')
    end
  end

  
end
