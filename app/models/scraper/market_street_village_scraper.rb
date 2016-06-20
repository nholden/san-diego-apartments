class Scraper::MarketStreetVillageScraper < Scraper
  LISTINGS_URL = "http://www.equityapartments.com/san-diego/downtown-san-diego/market-street-village-apartments?ilsid=93"

  private

  def self.building_name
    "Market Street Village"
  end

  def self.address
    "699 14th Street"
  end

  def self.website
    "http://www.equityapartments.com/san-diego/downtown-san-diego/market-street-village-apartments"
  end

  def self.page
    Nokogiri::HTML(open(LISTINGS_URL))
  end

  def self.raw_listings
    page.css('.list-group-item')
  end

  def self.unit_name(raw_listing)
    raw_listing.inner_html.match(/unitId: (\d+)/)[1]
  end

  def self.rent(raw_listing)
    raw_listing.css('.pricing').text.match(/[\d,]+/)[0].gsub(",", "").to_i
  end

  def self.available(raw_listing)
    Date.strptime(raw_listing.text.match(/Available (\d+\/\d+\/\d+)/)[1], "%m/%d/%Y")
  end

  def self.beds(raw_listing)
    raw_listing.text.match(/(\d) Bed/)[1].to_i
  end

  def self.square_feet(raw_listing)
    raw_listing.text.match(/(\d+) sq.ft./)[1].to_i
  end

  def self.lease_months(raw_listing)
    raw_listing.text.match(/(\d+) mo/)[1].to_i
  end
end
