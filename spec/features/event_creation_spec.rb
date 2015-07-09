require 'rails_helper'

feature 'event creation' do
  context 'signed out guest' do
    it 'should redirect to sign up' do
      visit root_path
      click_link 'Create Event'
      expect(current_path).to eq(new_user_path)

    end
  end
end
