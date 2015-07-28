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
    choose('Yes')
    click_button 'Update Group'
    expect(current_path).to eq group_path(@group)

    # check group is private
    sign_out
    visit group_path(@group)
    # expect(current_path).to eq 'eq

  end
end



