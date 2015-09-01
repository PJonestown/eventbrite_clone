require 'rails_helper'
include IntegrationHelper

feature 'event' do
  it 'should create, edit, and destroy an event' do
    user = create(:user)
    sign_in(user)

    # New and Create
    visit root_path
    click_link 'Create Event'
    expect(current_path).to eq(new_event_path)
    event = build(:event)
    fill_in 'Name', with: event.name
    fill_in 'Description', with: event.description
    click_button 'Create Event'
    event = Event.last
    expect(current_path).to eq event_path(event)
    expect(event.attendees.include?(user)).to eq true

    # Edit and Update
    click_link 'Edit Event'
    expect(current_path).to eq edit_event_path(event)
    fill_in 'Name', with: 'Edited Title'
    click_button 'Update Event'
    expect(current_path).to eq event_path(event)
    expect(page).to have_content 'Edited Title'

    # Destroy
    expect { click_link 'Delete Event' }.to change(Event, :count).by(-1)
    expect(current_path).to eq root_path
  end
end
