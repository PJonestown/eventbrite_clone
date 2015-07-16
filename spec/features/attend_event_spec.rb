require 'rails_helper'
include IntegrationHelper

feature 'attending an event' do
  before :each do
    create(:user)
    @event = create(:test_event)
    @user = create(:other_user) 
  end

  context 'signed in user' do
    it 'should let user attend event' do
     sign_in @user
     visit event_path(@event)
     expect(page).to have_button 'Attend'
    end
  end
end
