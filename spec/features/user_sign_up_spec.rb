require 'rails_helper'

feature 'user sign up proccess' do
  it 'should create new user' do
    visit root_path
    click_link 'Sign up'
    fill_in 'Username', with: 'a_name'
    click_button 'Create User'
    expect(current_path).to eq new_user_profile_path(User.last)
  end
end
