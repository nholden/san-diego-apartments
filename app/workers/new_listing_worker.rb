class NewListingWorker
  def perform(scraped_listing_id)
    scraped_listing = ScrapedListing.find(scraped_listing_id)
    building = Building.find_or_create_by(name: scraped_listing.building_name)
    unit = Unit.update_or_create_by_with_alerts(
      name: scraped_listing.unit_name,
      building_id: building.id,
      rent: scraped_listing.rent,
      available: scraped_listing.available,
      lease_months: scraped_listing.lease_months,
      square_feet: scraped_listing.square_feet,
      beds: scraped_listing.beds
    )
    Listing.create(
      rent: scraped_listing.rent,
      available: scraped_listing.available,
      lease_months: scraped_listing.lease_months,
      unit: unit
    )
  end
end
