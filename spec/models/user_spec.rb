require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of(:username) }
  it { should validate_uniqueness_of(:username) }

  it { should have_many(:created_events).class_name('Event') }
  it { should have_many(:created_events).with_foreign_key('creator_id') }

end
