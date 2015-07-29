require 'rails_helper'
include IntegrationHelper

feature 'private group' do
  before :each do
    @owner = create(:user)
    @group = create(:private_group, owner_id: @owner.id)
    @user = create(:other_user)
  end

  it 'should let the user join' do
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
    sign_in @owner
    visit group_join_requests_path(@group)
    expect(page).to have_content 'Please let me join'
    expect(page).to have_link @user.username
  end
end
