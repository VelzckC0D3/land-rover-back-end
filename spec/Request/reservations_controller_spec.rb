require 'rails_helper'

RSpec.describe Api::V1::ReservationsController, type: :controller do
  describe 'GET #index' do
    it 'returns a not_found response when no reservations are available' do
      get :index
      expect(response).to have_http_status(:not_found)
      expect(JSON.parse(response.body)['message']).to eq('No reservations found')
    end
  end

  describe 'POST #create' do
    it 'returns unprocessable_entity response on validation error' do
      post :create, params: { reservation: { city: '', date: Date.tomorrow } }
      expect(response).to have_http_status(:unprocessable_entity)
      expect(JSON.parse(response.body)['errors']).to include("City can't be blank")
    end
  end
end
