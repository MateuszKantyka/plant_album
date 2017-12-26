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
        expect(response).to redirect_to(user_path(User.first))
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
        expect(response).to redirect_to(signup_path)
      end
    end
  end

  describe '#update' do
    context 'when params are valid' do
      it 'update user, render user view, display successful flash message' do
        user = create(:user, admin: true)
        allow_any_instance_of(SessionsHelper).to receive(:current_user) { user }
        params =  { user: { name: 'mati'}, id: user.id}

        expect(put(:update, params: params))
        expect(user.reload.name).to eq 'mati'
        expect(flash[:success]).to eq 'Profile updated'
        expect(response).to redirect_to(user_path(User.first))
      end
    end

    context 'when params are not valid' do
      it 'display danger flash message and refresh view' do
        user = create(:user, admin: true)
        allow_any_instance_of(SessionsHelper).to receive(:current_user) { user }
        params =  { user: { name: ''}, id: user.id}

        expect(put(:update, params: params))
        expect(flash[:danger]).to eq 'Correct the field'
        expect(response).to redirect_to(edit_user_path(user))
      end
    end
  end

  describe '#destroy' do
    context 'when user is provided' do
      it 'delete user form datebase and display successful flash mesage' do
        user = create(:user, admin: true)
        allow_any_instance_of(SessionsHelper).to receive(:current_user) { user }
        
        expect { delete(:destroy, params: {id: user.id})}. to change {User.count}.from(1).to(0)
        expect(flash[:success]).to eq 'User successfully destroyed'
        expect(response).to redirect_to(users_path)
      end
    end
  end
end
