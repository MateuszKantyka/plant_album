require "rails_helper"
require 'sessions_helper'

RSpec.describe RefreshRating, request: true do
  describe '#call' do
    context "when mechanic doesn't has any comments" do
      it 'set mechanic rating to 0' do
        mechanic = create(:mechanic)

        RefreshRating.call(mechanic)

        expect(mechanic.rating).to eq 0
      end
    end

    context 'when mechanics has one comment' do
      context 'when comment has rating 3, 2, 1' do
        it 'set up mechanic rating as 2' do
          mechanic = create(:mechanic)
          user = create(:user)
          create(:comment, mechanic_id: mechanic.id, user_id: user.id,
            rating_general: 3, rating_time: 2, rating_cost: 1)

          RefreshRating.call(mechanic)

          expect(mechanic.rating).to eq 2
        end
      end

      context 'when comment has rating 1, 1, 2' do
        it 'set up mechanic rating as 1.33' do
          mechanic = create(:mechanic)
          user = create(:user)
          create(:comment, mechanic_id: mechanic.id, user_id: user.id,
            rating_general: 1, rating_time: 1, rating_cost: 2)

          RefreshRating.call(mechanic)

          expect(mechanic.rating).to eq 1.33
        end
      end
    end

    context 'when mechanics has two comments' do
      context 'when comments has rating 1,4,2 and 2,5,3' do
        it 'set up mechanic rating as 2.83' do
          mechanic = create(:mechanic)
          user = create(:user)
          create(:comment, mechanic_id: mechanic.id, user_id: user.id,
            rating_general: 1, rating_time: 4, rating_cost: 2)
          create(:comment, mechanic_id: mechanic.id, user_id: user.id,
            rating_general: 2, rating_time: 5, rating_cost: 3)

          RefreshRating.call(mechanic)

          expect(mechanic.rating).to eq 2.83
        end
      end

      context 'when comments has rating 5,4,4 and 3,5,4' do
        it 'set up mechanic rating as 4.17' do
          mechanic = create(:mechanic)
          user = create(:user)
          create(:comment, mechanic_id: mechanic.id, user_id: user.id,
            rating_general: 5, rating_time: 4, rating_cost: 4)
          create(:comment, mechanic_id: mechanic.id, user_id: user.id,
            rating_general: 4, rating_time: 5, rating_cost: 3)

          RefreshRating.call(mechanic)

          expect(mechanic.rating).to eq 4.17
        end
      end
    end
  end
end
