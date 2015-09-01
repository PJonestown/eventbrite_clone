require 'rails_helper'
include IntegrationHelper

feature 'event creation' do
  it 'should create, edit, and destroy an event' do
    user = create(:user)
    sign_in(user)

    # New and Create
    visit root_path
    click_link 'Create Event'
    expect(current_path).to eq(new_event_path)
    event = build(:event)
    fill_in 'Title', with: event.title
    fill_in 'Description', with: event.description
    click_button 'Create Event'
    event = Event.last
    expect(current_path).to eq event_path(event)

    # Edit and Update
    click_link 'Edit Event'
    expect(current_path).to eq edit_event_path(event)
    fill_in 'Title', with: 'Edited Title'
    click_button 'Update Event'
    expect(current_path).to eq event_path(event)
    expect(page).to have_content 'Edited Title'

    # Destroy
  end
end
