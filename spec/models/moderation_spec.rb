require 'rails_helper'

RSpec.describe Moderation, type: :model do
  it { should validate_presence_of(:moderator_id) }
  it { should validate_presence_of(:moderated_group_id) }
end
