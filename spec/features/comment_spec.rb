require 'rails_helper'

RSpec.feature 'Comment' do
  scenario 'user can create new comment' do
    create(:user)
    create(:mechanic)

    visit root_path
    click_on 'Log in'
    fill_in :session_email, with: 'mateusz.kantyka@hotmail.com'
    fill_in :session_password, with: '12345678'
    find('input[name="commit"]').click
    click_on 'Home'
    click_on 'More info'

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

    visit root_path
    click_on 'Log in'
    fill_in :session_email, with: 'mateusz.kantyka@hotmail.com'
    fill_in :session_password, with: '12345678'
    find('input[name="commit"]').click
    click_on 'Home'
    click_on 'More info'

    expect(page).not_to have_content 'Delete'

    fill_in :comment_content, with: 'My comment'
    fill_in :comment_cost, with: 120
    click_on 'Add comment'

    expect(page).to have_content 'Fill in all fields'
  end

  scenario "user can't delete other users comments" do

  end

  scenario "admin can delete all comments" do

  end

  scenario "user can delete only his own comments" do

  end
end
