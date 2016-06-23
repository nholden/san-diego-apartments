class Unit < ActiveRecord::Base
  belongs_to :building
  has_many :rent_alerts
  has_many :available_alerts
  has_many :new_unit_alerts

  scope :recently_seen, -> { where("last_seen > ?", 1.day.ago) }

  def self.update_or_create_by_with_alerts(attributes)
    unit = Unit.where(name: attributes[:name], building_id: attributes[:building_id]).last
    if unit.present?
      unit.assign_attributes(attributes)
      unit.save_with_alerts if unit.changed?
    else
      unit = create(attributes)
      NewUnitAlert.create(unit_id: unit.id)
    end
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
    created_at
  end

  def recent_rent_alerts
    rent_alerts.last(5).reverse
  end

  def rent_by_date
    {}.tap do |dates|
      rent_alerts.each { |rent_alert| dates[rent_alert.created_at.to_date] = rent_alert.new_value }
    end
  end
end
