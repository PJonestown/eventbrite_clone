class Category < ActiveRecord::Base
  has_many :groups

  validates :name, :presence => true
end
