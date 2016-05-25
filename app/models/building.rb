class Building < ActiveRecord::Base
  has_many :units
  validates :name, uniqueness: true
end
