class Group < ActiveRecord::Base
  has_many :gatherings
  belongs_to :owner, :class_name => 'User'

  has_many :memberships, :foreign_key => 'group_membership_id'
  has_many :members, :through => :memberships

  has_many :moderations, :foreign_key => 'moderated_group_id'
  has_many :moderators, :through => :moderations

  belongs_to :categories

  has_many :join_requests

  validates :name, :owner_id, :category_id, :description, :restriction_type, :presence => true
  validates :is_private, inclusion: [true, false]
  validates :name, :uniqueness => true
  validates :restriction_type, :inclusion => { :in => [0, 1, 2] }

  scope :is_public, -> { where(is_private: false) }
end
