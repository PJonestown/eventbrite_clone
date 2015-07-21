require 'rails_helper'
include IntegrationHelper

feature 'group creation' do
  context 'signed out guest' do
    it 'should redirect to sign up' do
      visit root_path
      click_link 'Start Group'
      expect(current_path).to eq(new_user_path)
    end
  end
end
