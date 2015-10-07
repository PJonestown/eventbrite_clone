require 'rails_helper'

feature 'user sign in/out proccess' do

  context 'registered user' do
    it 'should sign in/out the user' do
      # Sign in
      user = create(:user)
      visit root_path
      click_link 'Sign in'
      fill_in 'Username', with: user.username
      click_button 'Sign in'
      expect(current_path).to eq(root_path)
      expect(page).to have_content(user.username)

      # Sign out
      click_link 'Sign out'
      expect(current_path).to eq(root_path)
      expect(page).to have_link 'Sign in'
    end
  end
end
