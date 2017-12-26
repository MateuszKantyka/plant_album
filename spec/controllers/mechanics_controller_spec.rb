require "rails_helper"
require 'sessions_helper'

RSpec.describe MechanicsController, request: true do
  describe '#create' do
    context 'when all params are provided and user is admin' do
      it 'creates new verify mechanic and display successful flash message' do
        user = create(:user, admin: true)
        allow_any_instance_of(SessionsHelper).to receive(:current_user) { user }
        params =  { mechanic: { name: 'Example mechanic',
                            city: 'Żywiec',
                            post_code: '34-300',
                            address: 'ul. example 123',
                            phone_number: '111 222 333',
                            description: 'Example description'} }

        expect { post(:create, params: params) }.to change { Mechanic.count }.from(0).to(1)
        expect(Mechanic.first.verification).to eq true
        expect(flash[:success]).to eq 'Mechanic added'
        expect(response).to redirect_to(root_path)
      end
    end

    context "when all params are provided and user don't have admin role" do
      it 'creates new unverify mechanic and display successful flash message' do
        user = create(:user)
        allow_any_instance_of(SessionsHelper).to receive(:current_user) { user }
        params =  { mechanic: { name: 'Example mechanic',
                            city: 'Żywiec',
                            post_code: '34-300',
                            address: 'ul. example 123',
                            phone_number: '111 222 333',
                            description: 'Example description'} }

        expect { post(:create, params: params) }.to change { Mechanic.count }.from(0).to(1)
        expect(Mechanic.first.verification).to eq false
        expect(flash[:success]).to eq 'Mechanic added, wait to admin to verificate'
        expect(response).to redirect_to(root_path)
      end
    end

    context 'when params are not valid' do
      it 'display danger flash message and refresh view' do
        user = create(:user, admin: true)
        allow_any_instance_of(SessionsHelper).to receive(:current_user) { user }
        params =  { mechanic: { name: 'Example mechanic',
                            description: 'Example description'} }

        expect (post(:create, params: params))
        expect(flash[:danger]).to eq 'Fill up all required fielsd'
        expect(response).to redirect_to(notification_path)
      end
    end
  end

  describe '#update' do
    context 'when params are valid' do
      it 'update mechanic, render mechanic view, display successful flash message' do
        user = create(:user, admin: true)
        mechanic = create(:mechanic)
        allow_any_instance_of(SessionsHelper).to receive(:current_user) { user }
        params =  { mechanic: { name: 'Example mechanic' }, id: mechanic.id}

        expect(put(:update, params: params))
        expect(flash[:success]).to eq 'Mechanics updated'
        expect(mechanic.reload.name).to eq 'Example mechanic'
        expect(response).to redirect_to(mechanics_path)
      end
    end

    context 'when params are not valid' do
      it 'refresh edit mechanic view and display danger flash message' do
        user = create(:user, admin: true)
        mechanic = create(:mechanic)
        allow_any_instance_of(SessionsHelper).to receive(:current_user) { user }
        params =  { mechanic: { name: '' }, id: mechanic.id}

        expect(put(:update, params: params))
        expect(flash[:danger]).to eq 'Fill up all required fielsd'
        expect(response).to redirect_to(edit_mechanic_path(mechanic))
      end
    end
  end

  describe '#destroy' do
    context 'when mechanic is provided' do
      it 'delete mechanic form datebase and display successful flash message' do
        user = create(:user, admin: true)
        mechanic = create(:mechanic)
        allow_any_instance_of(SessionsHelper).to receive(:current_user) { user }

        expect { delete(:destroy, params: {id: mechanic.id})}. to change {Mechanic.count}.from(1).to(0)
        expect(flash[:success]).to eq 'Mechanic deleted'
        expect(response).to redirect_to(mechanics_path)
      end
    end
  end
end
