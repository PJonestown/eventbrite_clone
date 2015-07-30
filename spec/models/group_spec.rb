require 'rails_helper'

RSpec.describe Group, type: :model do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:owner_id) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:category_id) }
  it { should validate_presence_of(:restriction_type) }

  it { should allow_value(true).for(:is_private) }
  it { should allow_value(false).for(:is_private) }
  it { should_not allow_value(nil).for(:is_private) }

  it { should_not allow_value(3).for(:restriction_type) }

  it { should validate_uniqueness_of(:name) }
end
