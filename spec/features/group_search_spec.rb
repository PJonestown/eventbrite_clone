require 'rails_helper'
include GeocoderStubs
include IntegrationHelper

feature 'group search' do

  before do

    page.driver.options[:headers] = { 'REMOTE_ADDR' => '72.229.28.185' }

    category = Category.create(name: 'Tech')
    Category.create(name: 'Other')

    @user = create(:user)
    @group = create(:group, owner_id: @user.id, category_id: category.id)
    @other_group = create(:group, owner_id: @user.id, name: 'another', category_id: 2)
    @far_group = create(:group, owner_id: @user.id, name: 'someother')

    [@group, @other_group, @user].each do |h|
      Address.create(location: 'New York',
                     addressable_type: h.class.name,
                     addressable_id: h.id)
    end

    Address.create(location: 'Chicago',
                   addressable_type: 'Group',
                   addressable_id: @far_group.id)
  end

  context 'guest' do

    it 'should only show nearby groups' do
      visit groups_path
      expect(page).to have_content @group.name
      expect(page).to have_content @other_group.name
      expect(page).not_to have_content @far_group.name
    end

    it 'should not fail on timeout' do
      page.driver.options[:headers] = { 'REMOTE_ADDR' => '104.15.101.238' }

      visit groups_path
      expect(page).to have_content @group.name
      expect(page).to have_content @other_group.name
      expect(page).to have_content @far_group.name
    end
  end

  context 'user' do
    before do
      sign_in @user
    end

    it 'should only show nearby groups' do
      visit groups_path
      expect(page).to have_content @group.name
      expect(page).to have_content @other_group.name
      expect(page).not_to have_content @far_group.name
    end

    it 'should only show groups from selected category' do
      visit groups_path
      select 'Tech'
      click_button 'Search'
      expect(page).to have_content @group.name
      expect(page).not_to have_content @other_group.name
      expect(page).not_to have_content @far_group.name
    end
  end
end
