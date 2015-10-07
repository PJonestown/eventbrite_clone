require 'rails_helper'
include IntegrationHelper

feature 'attending an event' do
  before do
    first_user = create(:user)
    @event = create(:event, creator_id: first_user.id)
    @user = create(:other_user)
    create(:address, addressable_type: 'User', addressable_id: @user.id)
  end

  context 'signed in user' do
    it 'should let user attend and un-attend event' do
      # Attend
      sign_in @user
      visit event_path(@event)
      click_button 'Attend'

      # Un-attend
      expect(page).to have_button('Un-attend')
      click_button 'Un-attend'
      expect(page).to have_button 'Attend'
    end
  end

  context 'guest' do
    it 'should not show attend button' do
      visit event_path(@event)
      expect(page).not_to have_button 'Attend'
    end
  end
end
