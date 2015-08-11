require 'rails_helper'
include IntegrationHelper

feature 'group restrictions' do
  before :each do
    @owner = create(:user)
    @group = create(:group, owner_id: @owner.id)
    @user = create(:other_user)
    @mod = create(:user, username: 'the_mod')
    Membership.create(member_id: @owner.id,
                      group_membership_id: @group.id)
    Membership.create(member_id: @user.id,
                      group_membership_id: @group.id)
    Membership.create(member_id: @mod.id,
                      group_membership_id: @group.id)
    Moderation.create(moderator_id: @mod.id,
                      moderated_group_id: @group.id)
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
    expect(current_path).to eq group_gathering_path(@group, Gathering.last)
    expect(page).to have_content 'Anything'

    # Change restricted to true
    sign_out
    sign_in @owner
    visit edit_group_path(@group)
    choose 'group_restricted_true'
    click_button 'Update Group'

    # Moderators only
    sign_out
    sign_in @mod
    visit group_path(@group)
    click_link 'New Gathering'
    expect(current_path).to eq new_group_gathering_path(@group)
    fill_in 'Name', with: 'Mod gathering'
    fill_in 'Description', with: 'A new description'
    click_button 'Create Gathering'
    expect(current_path).to eq group_gathering_path(@group, Gathering.last)
    expect(page).to have_content 'Mod gathering'
  end
end
