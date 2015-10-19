require 'rails_helper'
include IntegrationHelper
include GeocoderStubs

feature 'user search' do

  before do

    @user = create(:user)
    @group = create(:group, owner_id: @user.id)
    @event = create(:event, creator_id: @user.id)
    @other_event = create(:another_event, creator_id: @user.id)
    @gathering = create(:gathering, creator_id: @user.id, group_id: @group)
    @far_gathering = create(:other_gathering, creator_id: @user.id, group_id: @group)
    @eighty_mile_event = create(:event, name: 'Worth the drive!', creator_id: @user.id)

    [@user, @event, @other_event, @gathering].each do |h|
      Address.create(location: 'New York',
                     addressable_type: h.class.name,
                     addressable_id: h.id)
    end

    Address.create(location: 'Chicago',
                   addressable_type: 'Gathering',
                   addressable_id: @far_gathering.id)

    Address.create(location: '06804',
                   addressable_type: 'Event',
                   addressable_id: @eighty_mile_event.id)
  end

  it 'should only show nearby happenings' do

    sign_in @user
    visit root_path
    expect(page).not_to have_content @far_gathering.name
    expect(page).not_to have_content @eighty_mile_event.name

    # Change radius params
    select(100)
    click_button 'Search'

    expect(page).not_to have_content @far_gathering.name
    expect(page).to have_content @eighty_mile_event.name
  end
end
