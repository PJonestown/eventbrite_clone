require 'rails_helper'
include GeocoderStubs

feature 'freegeoip timeout' do

  before do

    page.driver.options[:headers] = { 'REMOTE_ADDR' => '104.15.101.238' }

    user = create(:user)
    @group = create(:group, owner_id: user.id)
    @event = create(:event, creator_id: user.id)
    @other_event = create(:another_event, creator_id: user.id)
    @gathering = create(:gathering, creator_id: user.id, group_id: @group)
    @far_gathering = create(:other_gathering, creator_id: user.id, group_id: @group)
    @past_gathering = create(:gathering,
                             name: 'past_gathering',
                             creator_id: user.id,
                             group_id: @group,
                             date: Date.today - 4.days)
    @past_event = create(:event, name: 'past_event',
                         creator_id: user.id,
                         date: Date.today - 4.days)
    @unapproved_gathering = create(:unapproved_gathering, creator_id: user.id)

    new_york_happenings = [@event,
                           @other_event,
                           @gathering,
                           @past_gathering,
                           @past_event,
                           @unapproved_gathering]

    new_york_happenings.each do |h|
      Address.create(location: 'New York',
                     addressable_type: h.class.name,
                     addressable_id: h.id)
    end

    Address.create(location: 'Chicago',
                   addressable_type: 'Gathering',
                   addressable_id: @far_gathering.id)
  end

  it 'should show all gatherings' do
    visit root_path
    expect(page).to have_content @event.name
    expect(page).to have_content @other_event.name
    expect(page).to have_content @gathering.name
    expect(page).to have_content @far_gathering.name

    # Manually type invalid location
    fill_in 'city', with: 'hssghdsfjghafh'
    click_button 'Search'
    expect(page).not_to have_content @event.name
    expect(page).not_to have_content @other_event.name
    expect(page).not_to have_content @gathering.name
    expect(page).not_to have_content @far_gathering.name


    # Manually type valid location
    fill_in 'city', with: 'New York'
    click_button 'Search'
    expect(page).to have_content @event.name
    expect(page).to have_content @other_event.name
    expect(page).to have_content @gathering.name
    expect(page).not_to have_content @far_gathering.name
  end
end


