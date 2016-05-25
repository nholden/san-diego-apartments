class Scraper
  def self.scrape
    raw_listings.map do |raw_listing|
      ScrapedListing.create(
        building_name: building_name,
        unit_name:     unit_name(raw_listing),
        rent:          rent(raw_listing),
        available:     available(raw_listing),
        beds:          beds(raw_listing),
        square_feet:   square_feet(raw_listing),
        lease_months:  lease_months(raw_listing)
      )
    end
  end
end
