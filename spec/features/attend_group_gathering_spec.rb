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
      visit group_gathering_path(@group, @gathering)
      expect(page).not_to have_button 'Attend'
    end
  end

  context 'non-group member' do
    describe 'non-member attend gathering flow' do
      it 'should attend gathering' do
        # non-member
        user = create(:other_user)
        sign_in user

        visit group_gathering_path(@group, @gathering)
        expect(page).not_to have_button 'Attend'
        expect(page).to have_content 'Want to go?'
        expect(page).to have_button 'Join us!'
        click_button 'Join us!'
        expect(current_path).to eq group_gathering_path(@group, @gathering)

        # member
        click_button 'Attend'
      end
    end
  end
end
