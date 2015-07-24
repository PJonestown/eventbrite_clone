require 'rails_helper'
include IntegrationHelper

feature 'gathering creation' do
  before :each do
    @user = create(:user)
    @group = create(:group, owner_id: @user.id)
  end

  context 'signed out guest' do
    it 'should not have create event' do
      visit group_path(@group)
      expect(page).not_to have_content 'Create a Gathering'
    end
  end

  context 'group owner' do
    it 'should create a new group event' do
      sign_in @user
      visit group_path(@group)
      click_link 'Create a Gathering'
      expect(current_path).to eq new_group_gathering_path(@group)
      fill_in 'Name', with: 'New title'
      fill_in 'Description', with: 'Desc'
      click_button 'Create Gathering'
      expect(current_path).to eq group_path(@group)
      expect(page).to have_content 'New title'
    end
  end
end
