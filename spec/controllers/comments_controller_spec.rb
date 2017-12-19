require "rails_helper"
require 'sessions_helper'

RSpec.describe CommentsController, request: true do
  describe '#create' do
    context 'when all params are provided' do
      it 'creates new comment, refresh mechanic rating and display successful flash message' do
        user = create(:user)
        mechanic = create(:mechanic, rating: 0)
        params =  { comment: { content: 'great job',
                               car: 'Audi a8',
                               cost: 120.5,
                               rating_general: 5,
                               rating_cost: 2,
                               rating_time: 5,
                               mechanic_id: mechanic.id,
                               user: user } }

        allow_any_instance_of(SessionsHelper).to receive(:current_user) { user }
        expect { post(:create, params: params) }.to change { Comment.count }.from(0).to(1)
                                                .and change { mechanic.reload.rating }.from(0).to(4)

        expect(flash[:success]).to eq 'Comment successfully created'
        expect(response).to redirect_to(mechanic_path(mechanic))
      end
    end

    context 'when params are not valid' do
      it 'display danger flash mesage and reload view' do
        user = create(:user)
        mechanic = create(:mechanic, rating: 0)
        params =  { comment: { content: 'great job',
                               cost: 120.5,
                               rating_general: 5,
                               rating_time: 5,
                               mechanic_id: mechanic.id,
                               user: user } }

        allow_any_instance_of(SessionsHelper).to receive(:current_user) { user }
        post(:create, params: params)
        expect(flash[:danger]).to eq 'Fill in all fields'
        expect(response).to redirect_to(mechanic_path(mechanic))
      end
    end
  end
end
