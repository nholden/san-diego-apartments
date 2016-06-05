class NewListingWorker
  def perform(scraped_listing_id)
    scraped_listing = ScrapedListing.find(scraped_listing_id)
    building = Building.find_or_create_by(name: scraped_listing.building_name)
    unit = Unit.where(name: scraped_listing.unit_name, building: building).last
    unit_attributes = { rent: scraped_listing.rent,
                        available: scraped_listing.available,
                        lease_months: scraped_listing.lease_months,
                        square_feet: scraped_listing.square_feet,
                        beds: scraped_listing.beds,
                        name: scraped_listing.unit_name,
                        building: building }

    if unit.present?
      unit.assign_attributes(unit_attributes)
      unit.save_with_alerts if unit.changed?
    else
      unit = Unit.create_with_alerts(unit_attributes)
    end

    listing = Listing.create(rent: scraped_listing.rent,
                             available: scraped_listing.available,
                             lease_months: scraped_listing.lease_months,
                             unit: unit)
  end
end
