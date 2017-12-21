require 'rails_helper'

RSpec.feature 'User' do
  scenario 'user can sign up' do

  end

  scenario 'user can log in' do
    user = create(:user)
    visit root_path
    click_on 'Log in'
    fill_in :session_email, with: 'mateusz.kantyka@hotmail.com'
    fill_in :session_password, with: '12345678'
    find('input[name="commit"]').click
    expect(page).to have_content user.name
  end

  scenario 'user can log out' do

  end

  scenario 'user can display mechanic site' do

  end
end
