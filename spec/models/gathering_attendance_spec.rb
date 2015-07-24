require 'rails_helper'

RSpec.describe GatheringAttendance, type: :model do
  it { should validate_presence_of(:attendee_id) }
  it { should validate_presence_of(:attended_gathering_id) }
end
