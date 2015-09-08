require 'rails_helper'

feature 'user sign up proccess' do
  it 'should create new user and profile' do
    visit root_path
    click_link 'Sign up'
    fill_in 'Username', with: 'a_name'
    click_button 'Create User'
    expect(current_path).to eq new_user_profile_path(User.last)
    fill_in 'Zipcode', with: 'New York, NY, United States'
    expect{ click_button 'Create Profile' }.to change(Profile, :count).by(1)
  end
end
