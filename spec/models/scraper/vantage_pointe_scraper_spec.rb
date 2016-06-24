require 'rails_helper'

RSpec.describe Scraper::VantagePointeScraper, type: :model do
  describe ".scrape" do
    Given(:sample_page) { File.open('./spec/pages/vantage_pointe.html', 'r') }
    Given { stub_request(:get, Scraper::VantagePointeScraper::LISTINGS_URL).to_return(body: sample_page) }
    When(:scraped_listings) { Scraper::VantagePointeScraper.scrape }
    Then { scraped_listings.length == 48 }
    And { scraped_listings.first.class == ScrapedListing }
    And { scraped_listings.first.building_name == "Vantage Pointe" }
    And { scraped_listings.first.unit_name == "219" }
    And { scraped_listings.first.rent == 1920 }
    And { scraped_listings.first.available == Date.new(2016,8,8) }
    And { scraped_listings.first.beds == 1 }
    And { scraped_listings.first.square_feet == 706 }
    And { scraped_listings.first.lease_months == 12 }
  end
end
