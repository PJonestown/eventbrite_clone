require 'rails_helper'
include IntegrationHelper

feature 'event creation' do
  context 'signed out guest' do
    it 'should redirect to sign up' do
      visit root_path
      click_link 'Create Event'
      expect(current_path).to eq(new_user_path)
    end
  end

  context 'signed in user' do
    before(:each) do
      user = create(:user)
      sign_in(user)
    end

    it 'should create a new event' do
      visit root_path
      click_link 'Create Event'
      expect(current_path).to eq(new_event_path)
    end
  end
end
