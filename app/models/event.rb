class Event < ActiveRecord::Base
  belongs_to :creator, :class_name => 'User'

  validates :title, :description, :date, presence: true
end
