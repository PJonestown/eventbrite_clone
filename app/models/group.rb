class Group < ActiveRecord::Base
  has_many :events, inverse_of: :group
  has_many :gatherings
  belongs_to :owner, :class_name => 'User'

  has_many :memberships, :foreign_key => 'group_membership_id'
  has_many :members, :through => :memberships

  validates :name, :owner_id, :description, :presence => true
  validates :name, :uniqueness => true
end
