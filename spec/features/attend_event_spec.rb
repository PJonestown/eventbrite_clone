require 'rails_helper'
include IntegrationHelper

feature 'attending an event' do
  before :each do
    create(:user)
    @event = create(:test_event)
    @user = create(:other_user)
  end

  # TODO: this test passes on its own
  #       but it fails when running full test suite
  #       nilclass error @event.creator.username
  #       why?
  #       It has to be a problem with test_event factory

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
