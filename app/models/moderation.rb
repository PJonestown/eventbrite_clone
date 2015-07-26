class Moderation < ActiveRecord::Base
  validates :moderator_id, :moderated_group_id, :presence => true
end
