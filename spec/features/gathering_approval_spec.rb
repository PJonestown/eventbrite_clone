require 'rails_helper'
include IntegrationHelper

feature 'private group' do
  before do

    owner = create(:user)
    @group = create(:private_group,
                    owner_id: owner.id,
                    restricted: true)
    @user = create(:other_user)
    create(:address, addressable_type: 'User', addressable_id: @user.id)
    @mod = create(:user, username: 'the_mod')
    create(:address, addressable_type: 'User', addressable_id: @mod.id)
    Membership.create(member_id: @mod.id, group_membership_id: @group.id)
    Membership.create(member_id: @user.id, group_membership_id: @group.id)
    Moderation.create(moderator_id: @mod.id, moderated_group_id: @group.id)
  end

  it 'should approve the gathering' do
    # Member create unapproved gathering in restricted group
    sign_in @user
    visit group_path(@group)
    click_link 'Gathering Request'
    expect(current_path).to eq new_group_gathering_path(@group)
    expect(page).to have_content "This gathering won't be public until a moderator approves it."
    fill_in 'Name', with: 'a name'
    fill_in 'Description', with: 'a description'
    fill_in 'Date', with: Time.zone.now
    click_button 'Create Gathering'
    expect(current_path).to eq new_gathering_address_path(Gathering.last)
    visit group_path(@group)
    expect(page).not_to have_content 'a name'

    # Mod approves gathering and makes it public
    sign_out
    sign_in @mod
    visit user_mod_resources_path(@mod)
    expect(page).to have_content @group.name
    expect(page).to have_content @user.username
    click_link 'a name'
    gathering = Gathering.where(name: 'a name').first
    expect(current_path).to eq gathering_path(gathering)
    click_button 'Approve Gathering'
    visit group_path(@group)
    expect(page).to have_content 'a name'
    visit user_mod_resources_path(@mod)
    expect(page).not_to have_content 'a name'
  end
end
