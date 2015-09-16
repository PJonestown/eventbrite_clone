require 'rails_helper'

feature 'user sign up proccess' do
  it 'should create new user and profile' do
    # Sign up
    visit root_path
    click_link 'Sign up'
    fill_in 'Username', with: 'a_name'
    click_button 'Create User'
    expect(current_path).to eq new_user_profile_path(User.last)
    fill_in 'Location', with: 'New York, NY, United States'
    expect{ click_button 'Create Profile' }.to change(Profile, :count).by(1)

    # Edit and Update
    click_link 'Edit Profile'
    expect(current_path).to eq edit_user_profile_path(User.last, Profile.last)
    fill_in 'Location', with: 'Seattle, WA'
    click_button 'Update Profile'
    expect(current_path).to eq user_profile_path(User.last, Profile.last)
  end
end
