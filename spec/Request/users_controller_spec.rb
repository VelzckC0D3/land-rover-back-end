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

  describe 'GET #show' do
    it 'returns a success response with the requested user' do
      user = User.create(name: 'Test User', email: 'test@example.com', password: 'password')
      get :show, params: { id: user.id }
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)).to eq(user.as_json)
    end
  end

  describe 'POST #create' do
    it 'creates a new user' do
      post :create,
           params: { user: { name: 'New User', email: 'new@example.com', password: 'newpassword',
                             password_confirmation: 'newpassword' } }
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['success']).to be_truthy
      expect(JSON.parse(response.body)['user']['name']).to eq('New User')
    end

    it 'returns unprocessable_entity response on validation error' do
      post :create,
           params: { user: { name: '', email: 'invalidemail', password: 'password',
                             password_confirmation: 'password' } }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'PATCH #update' do
    let!(:user) { User.create(name: 'Test User', email: 'test@example.com', password: 'password') }

    it 'returns unprocessable_entity response on validation error' do
      patch :update, params: { id: user.id, user: { email: 'invalidemail' } }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
