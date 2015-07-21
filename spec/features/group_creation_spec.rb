require 'rails_helper'
include IntegrationHelper

feature 'group creation' do
  context 'signed out guest' do
    it 'should redirect to sign up' do
      visit root_path
      click_link 'Start Group'
      expect(current_path).to eq(new_user_path)
    end
  end

  context 'signed in user' do
    it 'should create a new group' do
      user = create(:user)
      sign_in user

      click_link 'Start Group'
      expect(current_path).to eq new_group_path
      fill_in 'Name', with: 'A brand new group'
      click_button 'Start Group'
      expect(current_path).to eq group_path(1)
    end
  end
end