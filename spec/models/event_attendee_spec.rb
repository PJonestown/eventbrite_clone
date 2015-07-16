require 'rails_helper'

RSpec.describe EventAttendee, type: :model do
  it { should belong_to(:attended_event).class_name('Event') }
  it { should belong_to(:attendee).class_name('User') }
end
