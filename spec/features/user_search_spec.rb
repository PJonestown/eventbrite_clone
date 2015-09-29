require 'rails_helper'
include IntegrationHelper
include GeocoderStubs

feature 'user search' do

  before do

    @user = create(:user)
    @group = create(:group, owner_id: @user.id)
    @event = create(:event, creator_id: @user.id)
    @other_event = create(:another_event, creator_id: @user.id)
    @far_group = create(:other_group, owner_id: @user.id)

    [@user, @group, @event, @other_event].each do |h|
      Address.create(location: 'New York',
                     addressable_type: h.class.name,
                     addressable_id: h.id)
    end

    Address.create(location: 'Chicago',
                   addressable_type: 'Group',
                   addressable_id: @far_group.id)
  end

  it 'should only nearby happenings' do

    sign_in @user
    visit root_path
  end
end

