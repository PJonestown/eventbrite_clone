require 'rails_helper'

RSpec.describe JoinRequest, type: :model do
  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:group_id) }
  it { should validate_presence_of(:message) }
end
