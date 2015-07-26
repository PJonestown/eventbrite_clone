class Moderation < ActiveRecord::Base
  belongs_to :moderator, :class_name => 'User'
  belongs_to :moderated_group, :class_name => 'Group'

  validates :moderator_id, :moderated_group_id, :presence => true
end
