class Gathering < ActiveRecord::Base
  belongs_to :creator, :class_name => 'User'

  validates :creator_id, :name, :description, :date, :presence => true
end
