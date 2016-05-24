class Scraper
  def self.listings
    raw_listings.map do |raw_listing|
      {
        unit_name:    unit_name(raw_listing),
        rent:         rent(raw_listing),
        available:    available(raw_listing),
        beds:         beds(raw_listing),
        square_feet:  square_feet(raw_listing),
        lease_months: lease_months(raw_listing)
      }
    end
  end
end
