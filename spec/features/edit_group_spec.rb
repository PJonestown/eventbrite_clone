require 'rails_helper'
include IntegrationHelper

feature 'editing a group' do
  before :each do
    @user = create(:user)
    @group = create(:group, owner_id: @user.id)
  end

  it 'should edit the group' do
    sign_in @user
    visit edit_group_path(@group)
    choose('No')
  end
end



