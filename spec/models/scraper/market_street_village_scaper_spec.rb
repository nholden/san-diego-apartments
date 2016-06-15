require 'rails_helper'

RSpec.describe Scraper::MarketStreetVillageScraper, type: :model do
  describe ".scrape" do
    Given(:sample_page) { File.open('./spec/pages/market_street_village.html', 'r') }
    Given { stub_request(:get, Scraper::MarketStreetVillageScraper::LISTINGS_URL).to_return(body: sample_page) }
    When(:scraped_listings) { Scraper::MarketStreetVillageScraper.scrape }
    Then { scraped_listings.length == 12 }
    And { scraped_listings.first.class == ScrapedListing }
    And { scraped_listings.first.building_name == "Market Street Village" }
    And { scraped_listings.first.unit_name == "313" }
    And { scraped_listings.first.rent == 1625 }
    And { scraped_listings.first.available == Date.new(2016,06,21) }
    And { scraped_listings.first.beds == 0 }
    And { scraped_listings.first.square_feet == 491 }
    And { scraped_listings.first.lease_months == 12 }
  end
end
