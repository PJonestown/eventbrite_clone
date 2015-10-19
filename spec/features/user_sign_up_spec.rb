require 'rails_helper'
include GeocoderStubs

feature 'user sign up proccess' do
  it 'should create new user and profile' do
    # Sign up
    visit root_path
    click_link 'Sign up'
    fill_in 'Username', with: 'a_name'
    click_button 'Create User'

    # Address
    expect(current_path).to eq new_user_address_path(User.last)
    fill_in 'Location', with: 'New York'
    click_button 'Create Address'
    expect(User.last.address.latitude).not_to eq nil
    expect(current_path).to eq user_path(User.last)

    # Edit and Update
    click_link 'Profile'
    expect(current_path).to eq user_path(User.last)
    click_link 'Edit Location'
    expect(current_path).to eq edit_user_address_path(User.last, Address.last)
    fill_in 'Location', with: 'Chicago'
    click_button 'Update Address'
    # expect(current_path).to eq user_path(User.last)
    expect(User.last.address.latitude).to eq 41.8781136
  end
end
