require "rails_helper"
require 'sessions_helper'
RSpec.describe UsersController, request: true do
  describe '#create' do
    context 'when all params are provided' do
      it 'creates new user, log in new user, and display successful flash message' do
        params =  { user: { name: 'mati',
                            email: 'mati@wp.pl',
                            password: '12345678',
                            password_confirmation: '12345678' } }

        expect { post(:create, params: params) }.to change { User.count }.from(0).to(1)
        expect(flash[:success]).to eq 'User successfully created'
        #expect(response).to redirect_to(users_path(1))
        expect(session[:user_id]).to eq 1
      end
    end

    context 'when params are not valid' do
      it 'display danger flash mesage and reload view' do
        params =  { user: { name: 'mati',
                            password: '12345678'} }

        expect(post(:create, params: params))
        expect(flash[:danger]).to eq 'Correct the field'
        expect(session[:user_id]).to eq nil
      end
    end
  end

  describe '#destroy' do
    context 'when user is provided' do
      it 'delete user form datebase' do
        user = create(:user)
        params = {user: {id: user.id}}
        #expect(delete(:destroy, params: params))
        expect{delete :destroy, params: params}
        expect(User.count).to eq 0
      end
    end
  end
end
