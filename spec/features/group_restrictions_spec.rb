require 'rails_helper'
include IntegrationHelper

feature 'group restrictions' do
  before :each do
    @owner = create(:user)
    @group = create(:group, owner_id: @owner.id)
    @user = create(:other_user)
    @mod = create(:user, username: 'the_mod')
    Membership.create(member_id: @owner.id, group_membership_id: @group.id)
    Membership.create(member_id: @user.id, group_membership_id: @group.id)
    Membership.create(member_id: @mod.id, group_membership_id: @group.id)
  end

  it 'should change restriction settings' do
    # All group members
    sign_in @user
    visit group_path(@group)
    click_link 'New Gathering'
    expect(current_path).to eq new_group_gathering_path(@group)
    fill_in 'Name', with: 'Anything'
    fill_in 'Description', with: 'A new description'
    click_button 'Create Gathering'
    expect current_path.to eq group_path(@group)
    expect(page).to have_content 'Anything'
  end
end
