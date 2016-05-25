class Unit < ActiveRecord::Base
  belongs_to :building
  has_many :listings
  validates :name, uniqueness: true
end
