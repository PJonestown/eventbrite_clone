require 'rails_helper'
include IntegrationHelper

feature 'gathering creation' do
  before :each do
    @user = create(:user)
    @group = create(:group, owner_id: @user.id)
    Membership.create(member_id: @user.id, group_membership_id: @group.id)
  end

  context 'signed out guest' do
    it 'should not have create event' do
      visit group_path(@group)
      expect(page).not_to have_content 'Create a Gathering'
    end
  end

  context 'group owner' do
    it 'should create a new group event' do
      # Creating
      sign_in @user
      visit group_path(@group)
      click_link 'New Gathering'
      expect(current_path).to eq new_group_gathering_path(@group)
      fill_in 'Name', with: 'New title'
      fill_in 'Description', with: 'Desc'
      click_button 'Create Gathering'
      expect(current_path).to eq gathering_path(Gathering.last)
      expect(page).to have_content 'New title'

      # Editing and Updating
      click_link 'Edit'
      expect(current_path).to eq edit_gathering_path(Gathering.last)
      fill_in 'Name', with: 'Edited name'
      click_button 'Update Gathering'
      expect(current_path).to eq gathering_path(Gathering.last)
      expect(page).to have_content 'Edited name'

      # Deleting and Destroying
      click_link 'Delete Gathering'
      expect(current_path).to eq group_path(@group)
      expect(page).not_to have_content 'Edited name'
    end
  end
end
