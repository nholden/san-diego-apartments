class Listing < ActiveRecord::Base
  belongs_to :unit

  def save_with_alerts
    if unit.listings.present? && rent != unit.rent
      RentAlert.create(old_value: unit.rent, new_value: rent, unit: unit)
    end

    save
  end
end
