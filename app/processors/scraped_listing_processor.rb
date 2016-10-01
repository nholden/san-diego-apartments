class ScrapedListingProcessor
  def self.process(building_name:, address:, website:, unit_name:, rent:, available:, beds:, square_feet:, lease_months:)
    building = Building.find_or_create_by(name: building_name)
    building.update_attributes(address: address, website: website)
    unit = Unit.update_or_create_by_with_alerts(
      name: unit_name,
      building_id: building.id,
      rent: rent,
      available: available,
      lease_months: lease_months,
      square_feet: square_feet,
      beds: beds,
      last_seen: DateTime.now
    )
  end
end
