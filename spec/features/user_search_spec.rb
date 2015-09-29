require 'rails_helper'
include IntegrationHelper

feature 'user search' do

  before do

    Geocoder.configure(:lookup => :test)

    Geocoder::Lookup::Test.add_stub(
      'New York', [
        {
          'location'     => 'New York',
          'latitude'     => 40.7143528,
          'longitude'    => -74.0059731
        }
      ]
    )

    Geocoder::Lookup::Test.add_stub(

      'Chicago', [
        {
          'location'    => 'Chicago',
          'latitude'    => 41.8781136,
          'longitude'   => -87.6297982
        }
      ]
    )

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

