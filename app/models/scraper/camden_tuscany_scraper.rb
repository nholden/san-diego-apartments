class Scraper::CamdenTuscanyScraper < Scraper
  LISTINGS_URL = "https://www.camdenliving.com/san-diego-ca-apartments/camden-tuscany/apartments"

  private

  def self.building_name
    "Camden Tuscany"
  end

  def self.address
    "1670 Kettner Blvd"
  end

  def self.website
    "https://www.camdenliving.com/san-diego-ca-apartments/camden-tuscany/apartments"
  end

  def self.page
    Nokogiri::HTML(open(LISTINGS_URL))
  end

  def self.raw_listings
    page.css('.node-card-bottom')
  end

  def self.unit_name(raw_listing)
    raw_listing.css('.unit-name').text.match(/\d+/)[0]
  end

  def self.rent(raw_listing)
    raw_listing.css('.price').children[2].text.match(/\d+/)[0].to_i
  end

  def self.available(raw_listing)
    Date.parse(raw_listing.css('.move-in-date').text)
  end

  def self.beds(raw_listing)
    raw_listing.css('.unit-info').text.match(/Beds (\d)/)[1].to_i
  end

  def self.square_feet(raw_listing)
    raw_listing.css('.unit-info').text.match(/SqFt (\d+)/)[1].to_i
  end

  def self.lease_months(raw_listing)
    raw_listing.css('.lease-contract').text.match(/(\d+) Months/)[1].to_i
  end
end
