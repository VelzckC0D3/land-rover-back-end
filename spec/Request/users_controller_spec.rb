require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
  describe 'GET #index' do
    it 'returns a success response with users if available' do
      user = User.create(name: 'Test User', email: 'test@example.com', password: 'password')
      get :index
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['success']).to be_truthy
      expect(JSON.parse(response.body)['users']).to eq([user.as_json])
    end

    it 'returns a not_found response when no users are available' do
      get :index
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['success']).to be_falsy
      expect(JSON.parse(response.body)['message']).to eq('No Users Found')
    end

    it 'returns an internal_server_error response on exception' do
      allow(User).to receive(:all).and_raise(StandardError.new('Test Error'))
      get :index
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['success']).to be_falsy
      expect(JSON.parse(response.body)['message']).to eq('Test Error')
    end
  end

  
end
