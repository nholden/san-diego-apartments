class Unit < ActiveRecord::Base
  belongs_to :building
  has_many :listings
  has_many :rent_alerts
  has_many :available_alerts
  has_many :new_unit_alerts

  validates :name, uniqueness: true

  def self.create_with_alerts(attributes)
    unit = create(attributes)
    NewUnitAlert.create(unit_id: unit.id)
    unit
  end

  def save_with_alerts
    RentAlert.create(unit_id: id, old_value: rent_was, new_value: rent) if rent_changed?
    AvailableAlert.create(unit_id: id, old_value: available_was, new_value: available) if available_changed?
    save
  end

  def building_name
    building.name
  end

  def first_seen
    listings.first.created_at
  end

  def last_seen
    listings.last.created_at
  end
end
