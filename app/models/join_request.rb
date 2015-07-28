class JoinRequest < ActiveRecord::Base
  belongs_to :user
  belongs_to :group

  validates :user_id, :group_id, :message, :presence => true
end
