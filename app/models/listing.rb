class Listing < ActiveRecord::Base
  belongs_to :unit, touch: true

  def save_with_alerts
    if unit.new?
      NewUnitAlert.create(unit: unit)
    else
      RentAlert.create(old_value: unit.rent, new_value: rent, unit: unit) if rent != unit.rent
      AvailableAlert.create(old_value: unit.available, new_value: available, unit: unit) if available != unit.available
    end

    save
  end
end
