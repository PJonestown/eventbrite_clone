require 'rails_helper'

RSpec.describe Gathering, type: :model do
  it { should validate_presence_of(:creator_id) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:date) }
end
