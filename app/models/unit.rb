class Unit < ActiveRecord::Base
  belongs_to :building
  has_many :listings
  has_many :price_alerts
  validates :name, uniqueness: true

  def building_name
    building.name
  end

  def rent
    listings.last.rent
  end

  def available
    listings.last.available
  end

  def lease_months
    listings.last.lease_months
  end

  def first_seen
    listings.first.created_at
  end

  def last_seen
    listings.last.created_at
  end
end
