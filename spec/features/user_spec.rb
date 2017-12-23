require 'rails_helper'

RSpec.feature 'User' do
  scenario 'user can sign up' do
    visit root_path
    click_on 'Sign up'
    fill_in :user_name, with: 'Mateusz'
    fill_in :user_email, with: 'mateusz.kantyka@hotmail.com'
    fill_in :user_password, with: '12345678'
    fill_in :user_password_confirmation, with: '12345678'

    find('input[name="Sign up button"]').click
    expect(page).to have_content 'User successfully created'
    expect(User.last.name).to eq('Mateusz')
  end

  scenario 'user can log in and log out' do
    user = create(:user)
    visit root_path
    click_on 'Log in'
    fill_in :session_email, with: 'mateusz.kantyka@hotmail.com'
    fill_in :session_password, with: '12345678'
    find('input[name="Log in button"]').click
    expect(page).to have_content user.name
    expect(page).to have_content 'Welcome!'
    click_on 'Log out'
    expect(page).not_to have_content 'Profile'
  end

  scenario 'user can display mechanic site' do
    user = create(:user)
    create(:mechanic)
    allow_any_instance_of(SessionsHelper).to receive(:current_user) { user }
    visit 'users/1'
    click_on 'Home'
    click_on 'More info'
    expect(page).to have_content 'Nowak autoMechanic s.c.'
  end
end
