require 'rails_helper'
include IntegrationHelper

feature 'private group' do
  before :each do
    owner = create(:user)
    @group = create(:private_group, owner_id: owner.id, restricted: true)
    @user = create(:other_user)
    @mod = create(:user, username: 'the_mod')
    Membership.create(member_id: @mod.id, group_membership_id: @group.id)
    Moderation.create(moderator_id: @mod.id, moderated_group_id: @group.id)
  end

  it 'should let the user join/leave' do
    # Request access to group
    sign_in @user
    visit groups_path
    visit group_path(@group)
    expect(current_path).to eq new_group_join_request_path(@group)
    fill_in 'Message', with: 'Please let me join!'
    click_button 'Send Join Request'
    expect(current_path).to eq root_path

    # Owner gives access to group
    sign_out
    sign_in @mod
    visit group_join_requests_path(@group)
    expect(page).to have_content 'Please let me join'
    expect(page).to have_link @user.username
    click_button "Make #{@user.username} a Member"
    expect(current_path).to eq group_memberships_path(@group)

    # User has access to group and leaves
    sign_out
    sign_in @user
    visit group_path(@group)
    expect(current_path).to eq group_path(@group)
    click_button 'Leave Group'
    visit group_path(@group)
    expect(current_path).to eq new_group_join_request_path(@group)
  end
end
