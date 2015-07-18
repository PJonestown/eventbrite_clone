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
  #       capybara can't find button 'attend'
  #       weird...
  context 'signed in user' do
    it 'should let user attend event' do
      sign_in @user
      visit event_path(@event)
      click_button 'Attend'
      expect(page).to have_button('Un-attend')
    end
  end
end
