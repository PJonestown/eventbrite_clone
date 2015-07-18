require 'rails_helper'

RSpec.describe Attendance, type: :model do
  it { should belong_to(:attended_event).class_name('Event') }
  it { should belong_to(:attendee).class_name('User') }

  it { should validate_presence_of(:attended_event_id) }
  it { should validate_presence_of(:attendee_id) }
end
