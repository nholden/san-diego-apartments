class SeedRentAvailableAndLeaseMonthsInUnits < ActiveRecord::Migration
  def change
    Unit.all.each do |unit|
      unit.update_attribute(:rent, unit.listings.last.rent)
      unit.update_attribute(:available, unit.listings.last.available)
      unit.update_attribute(:lease_months, unit.listings.last.lease_months)
    end
  end
end
