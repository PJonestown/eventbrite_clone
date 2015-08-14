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
      category = create(:category)
      sign_in user
      click_link 'Start Group'
      expect(current_path).to eq new_group_path
      fill_in 'Name', with: 'A brand new group'
      fill_in 'Description', with: 'Now even newer!'
      select(category.name)
      click_button 'Start Group'
      expect(current_path).to eq group_path(user.owned_groups.last)
      group = Group.last
      expect(group.members.include?(user)).to eq true
    end
  end
end
