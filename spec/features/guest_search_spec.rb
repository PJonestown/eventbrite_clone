require 'rails_helper'
include GeocoderStubs



feature 'user search' do

  before do

    #allow_any_instance_of(ActionDispatch::Request).to receive(:location) do 
  #instance_double("Geocoder::Result::Freegeoip", :latitude => 40.732,
   #                                              :longitude => -73.989,
    #                                             :city => 'New York',
     #                                            :country_code => 'US')
    #end
allow_any_instance_of(ActionDispatch::Request).to receive(:location) do 
   instance_double("Geocoder::Result::Freegeoip", :latitude => 40.7320,
                                                  :longitude => -73.989,
                                                  :ip => '72.229.28.185',
                                                  :city => 'New York',
                                                  :metrocode => 10003,
                                                  :country_code => 'US')

end

    page.driver.options[:headers] = { 'REMOTE_ADDR' => '72.229.28.185' }
    user = create(:user)
    @group = create(:group, owner_id: user.id)
    @event = create(:event, creator_id: user.id)
    @other_event = create(:another_event, creator_id: user.id)
    @gathering = create(:gathering, creator_id: user.id, group_id: @group)
    @far_gathering = create(:other_gathering, creator_id: user.id, group_id: @group)

    [@event, @other_event, @gathering].each do |h|
      Address.create(location: 'New York',
                     addressable_type: h.class.name,
                     addressable_id: h.id)
    end

    Address.create(location: 'Chicago',
                   addressable_type: 'Gathering',
                   addressable_id: @far_gathering.id)
  end

  it 'should only show New York happenings' do
    visit root_path
    expect(page).to have_content @event.name
    expect(page).to have_content @other_event.name
    expect(page).to have_content @gathering.name
    expect(page).not_to have_content @far_gathering.name
  end
end
