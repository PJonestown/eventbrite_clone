class Membership < ActiveRecord::Base
  belongs_to :member, class_name: 'User'
  belongs_to :group_membership, class_name: 'Group'

  validates :member_id, :group_membership_id, :presence => true
end
