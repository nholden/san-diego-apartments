require 'rails_helper'

RSpec.describe Scraper::AvaCortezHillScraper, type: :model do
  SAMPLE_JSON = File.open('./spec/pages/ava_cortez_hill.json', 'r')

  describe ".scrape" do
    Given { stub_request(:get, Scraper::AvaCortezHillScraper::LISTINGS_URL).to_return(body: SAMPLE_JSON) }
    When(:scraped_listings) { Scraper::AvaCortezHillScraper.scrape }
    Then { scraped_listings.length == 25 }
    And { scraped_listings.first.class == ScrapedListing }
    And { scraped_listings.first.building_name == "Ava Cortez Hill" }
    And { scraped_listings.first.unit_name == "505" }
    And { scraped_listings.first.rent == 1565 }
    And { scraped_listings.first.available == Date.new(2016,05,27) }
    And { scraped_listings.first.beds == 0 }
    And { scraped_listings.first.square_feet == 570 }
    And { scraped_listings.first.lease_months == 12 }
  end
end
