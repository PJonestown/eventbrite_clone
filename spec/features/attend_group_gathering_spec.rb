require 'rails_helper'
include IntegrationHelper

feature 'attending a group gathering' do
  before :each do
    owner = create(:user)
    @group = create(:group, owner_id: owner.id)
    @gathering = create(:gathering, creator_id: owner.id, group_id: @group.id)
  end

  context 'guest' do
    it 'should not show attend button' do
      visit gathering_path(@gathering)
      expect(page).not_to have_button 'Attend'
    end
  end

  context 'non-group member' do
    describe 'non-member attend gathering flow' do
      it 'should attend/un-attend gathering' do
        # non-member
        user = create(:other_user)
        create(:address, addressable_type: 'User', addressable_id: user.id)
        sign_in user

        visit gathering_path(@gathering)
        expect(page).to have_content 'Want to go?'
        expect(page).to have_button 'Join us!'
        click_button 'Join us!'
        expect(current_path).to eq gathering_path(@gathering)

        # member attend
        click_button 'Attend'
        expect(current_path).to eq gathering_path(@gathering)
        expect(page).to have_content user.username
        expect(page).to_not have_button 'Attend'
        expect(page).to have_button 'Un-attend'

        # member un-attend
        click_button 'Un-attend'
        expect(page).to have_button 'Attend'
      end
    end
  end
end
