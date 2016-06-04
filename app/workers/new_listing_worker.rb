class NewListingWorker
  def perform(scraped_listing_id)
    scraped_listing = ScrapedListing.find(scraped_listing_id)
    building = Building.find_or_create_by(name: scraped_listing.building_name)
    unit = building.units.find_or_create_by(name: scraped_listing.unit_name)
    unit.update_attributes(square_feet: scraped_listing.square_feet, beds: scraped_listing.beds)
    unit.save if unit.changed?

    listing = Listing.new(
      rent: scraped_listing.rent,
      available: scraped_listing.available,
      lease_months: scraped_listing.lease_months,
      unit: unit
    )

    listing.save_with_alerts
  end
end
