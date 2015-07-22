require 'rails_helper'
include IntegrationHelper

feature 'attending an event' do
  before :each do
    first_user = create(:user)
    @group = create(:group, owner_id: first_user.id)
    @user = create(:other_user)
  end

  context 'signed in users' do
    it 'lets user join/leave group' do
      # join
      sign_in @user
      visit group_path(@group)
      click_button 'Join Group'

      # leave
      click_button 'Leave Group'
    end
  end
end
