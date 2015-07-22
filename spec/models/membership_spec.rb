require 'rails_helper'

RSpec.describe Membership, type: :model do
  it { should validate_presence_of(:member_id) }
  it { should validate_presence_of(:group_membership_id) }
end
