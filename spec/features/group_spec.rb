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
    it 'should create, edit, and destroy group' do
      user = create(:user)
      category = create(:category)
      sign_in user

      # New and Create
      click_link 'Start Group'
      expect(current_path).to eq new_group_path
      fill_in 'Name', with: 'A brand new group'
      fill_in 'Description', with: 'Now even newer!'
      select(category.name)
      click_button 'Create Group'
      expect(Group.last.members.include?(user)).to eq true

      # Address
      expect(current_path).to eq new_group_address_path(Group.last)
      fill_in 'Location', with: 'Seattle'
      click_button 'Create Address'
      expect(Group.last.address.latitude).not_to eq nil
      expect(current_path).to eq group_path(Group.last)

      # Edit and Update
      click_link 'Edit Group'
      fill_in 'Name', with: 'Edited Name'
      click_button 'Update Group'
      expect(page).to have_content 'Edited Name'

      # Destroy
      click_link 'Delete Group'
      expect(current_path).to eq root_path
      expect(page).not_to have_content 'Edited Name'
    end
  end
end
