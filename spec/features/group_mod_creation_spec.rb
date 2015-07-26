require 'rails_helper'
include IntegrationHelper

feature 'attending an event' do
  before :each do
    @owner = create(:user)
    @group = create(:group, owner_id: @owner.id)
    @user = create(:other_user)
  end

  context 'group owner' do
    it 'should create a new mod' do
      sign_in @owner
      visit new_user_moderation_path(@user)
      expect(page).to have_content "Make #{@user.username} a moderator of"
      select(@group.name)
      click_button 'Create new moderator'
      expect(current_path).to eq group_path(@group)
    end
  end
end
