require 'rails_helper'
include IntegrationHelper

feature 'private group' do
  before :each do
    @owner = create(:user)
    @group = create(:private_group, owner_id: @owner.id)
    @user = create(:other_user)
  end

  it 'should let the user join' do
    sign_in @user
    visit groups_path
    expect(page).not_to have_content @group.name
  end
end
