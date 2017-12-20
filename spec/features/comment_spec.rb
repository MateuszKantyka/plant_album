require 'rails_helper'
include SessionsHelper

RSpec.feature 'Comment' do
  scenario 'user can create new comment' do
    user = create(:user)
    create(:mechanic)

    allow_any_instance_of(SessionsHelper).to receive(:current_user) { user }

    visit 'mechanics/1'
    expect(page).not_to have_content 'Delete'

    fill_in :comment_content, with: 'My comment'
    fill_in :comment_car, with: 'Audi a8'
    fill_in :comment_cost, with: 120
    fill_in :comment_rating_cost, with: 1
    fill_in :comment_rating_time, with: 2
    fill_in :comment_rating_general, with: 3
    click_on 'Add comment'

    expect(page).to have_content 'Comment successfully created'
  end

  scenario "user can't create new comment without fill up all data" do
    user = create(:user)
    create(:mechanic)

    allow_any_instance_of(SessionsHelper).to receive(:current_user) { user }

    visit 'mechanics/1'
    expect(page).not_to have_content 'Delete'

    fill_in :comment_content, with: 'My comment'
    fill_in :comment_cost, with: 120
    click_on 'Add comment'

    expect(page).to have_content 'Fill in all fields'
  end

  scenario "user can't delete other users comments" do
    user = create(:user)
    user2 = create(:user, email: 'example@wp.pl')
    mechanic = create(:mechanic)
    create(:comment, mechanic: mechanic, user: user2)

    allow_any_instance_of(SessionsHelper).to receive(:current_user) { user }
    visit 'mechanics/1'

    expect(page).to have_content 'example comment'
    expect(page).not_to have_content 'Delete'
  end

  scenario "user can delete only his own comments" do
    user = create(:user)
    user2 = create(:user, email: 'example@wp.pl')
    mechanic = create(:mechanic)
    create(:comment, mechanic: mechanic, user: user)
    create(:comment, mechanic: mechanic, user: user2)

    allow_any_instance_of(SessionsHelper).to receive(:current_user) { user }
    visit 'mechanics/1'

    expect(page).to have_content('example comment', count: 2)
    expect(page).to have_selector(:link_or_button, 'Delete', count: 1)
    click_on 'Delete'
    expect(page).to have_content 'Comment successfully destroyed'
  end

  scenario "admin can delete all comments" do
    admin = create(:user, admin: true)
    user = create(:user, email: 'example@mail.com')
    mechanic = create(:mechanic)
    create(:comment, mechanic: mechanic, user: user)

    allow_any_instance_of(SessionsHelper).to receive(:current_user) { admin }
    visit 'mechanics/1'

    expect(page).to have_content 'example comment'
    expect(page).to have_selector(:link_or_button, 'Delete')
    click_on 'Delete'
    expect(page).to have_content 'Comment successfully destroyed'
  end
end
