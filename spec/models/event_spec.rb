require 'rails_helper'

RSpec.describe Event, type: :model do
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:date) }

  it { should belong_to(:creator).class_name('User') }
  it { should have_many(:attendees).through(:attendances) }
end
