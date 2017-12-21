require 'rails_helper'

RSpec.feature 'Mechanic' do
  scenario 'user can create new unverify mechanic' do
    user = create(:user)
    allow_any_instance_of(SessionsHelper).to receive(:current_user) { user }

    visit root_path
    click_on 'New Mechanic'
    fill_in :mechanic_name, with: 'Example mechanic'
    fill_in :mechanic_city, with: 'Bielsko-Biała'
    fill_in :mechanic_post_code, with: '43-300'
    fill_in :mechanic_address, with: 'ul. example 123'
    fill_in :mechanic_phone_number, with: '350 732 005'
    fill_in :mechanic_description, with: 'Example description'

    click_on 'Add mechanic'
    expect(page).to have_content 'Mechanic added'
    expect(Mechanic.last.verification).to eq(false)
  end

  scenario 'admin can create new verify mechanic' do
    user = create(:user, admin: true)
    allow_any_instance_of(SessionsHelper).to receive(:current_user) { user }

    visit root_path
    click_on 'New Mechanic'
    fill_in :mechanic_name, with: 'Example mechanic'
    fill_in :mechanic_city, with: 'Bielsko-Biała'
    fill_in :mechanic_post_code, with: '43-300'
    fill_in :mechanic_address, with: 'ul. example 123'
    fill_in :mechanic_phone_number, with: '350 732 005'
    fill_in :mechanic_description, with: 'Example description'

    click_on 'Add mechanic'
    expect(page).to have_content 'Mechanic added'
    expect(Mechanic.last.verification).to eq(true)
  end

  scenario "user can't create new mechanic without fill up all required fielsd" do
    user = create(:user)
    allow_any_instance_of(SessionsHelper).to receive(:current_user) { user }

    visit root_path
    click_on 'New Mechanic'
    fill_in :mechanic_description, with: 'Example mechanic'

    click_on 'Add mechanic'
    expect(page).to have_content 'Fill up all required fielsd'
  end

  scenario 'guest can display mechanic site' do
    create(:mechanic)
    visit root_path
    click_on 'More info'
    expect(page).to have_content 'Description'
  end

  scenario 'admin can edit mechanic' do
    admin = create(:user, admin: true)
    create(:mechanic)
    allow_any_instance_of(SessionsHelper).to receive(:current_user) { admin }

    visit root_path
    click_on 'Mechanics'
    click_on 'Edit'
    fill_in :mechanic_phone_number, with: '645 234 214'

    click_on 'Edit'
    expect(page).to have_content 'Mechanics updated'
  end

  scenario 'admin can delete mechanic' do
    user = create(:user, admin: true)
    create(:mechanic)
    allow_any_instance_of(SessionsHelper).to receive(:current_user) { user }

    visit root_path
    click_on 'Mechanics'
    click_on 'Delete'
    expect(page).to have_content 'Mechanic deleted'
    expect(page).not_to have_content 'Delete'
  end

  scenario 'when mechanic cords is empty google maps is off' do
    create(:mechanic)
    visit 'mechanics/1'
    expect(page).not_to have_content 'Location:'
  end

  scenario 'when mechanic cords is fill up google maps is on' do
    create(:mechanic, lat: 49.6209646, lng: 19.1471016)
    visit 'mechanics/1'
    expect(page).to have_content 'Location:'
  end
end
