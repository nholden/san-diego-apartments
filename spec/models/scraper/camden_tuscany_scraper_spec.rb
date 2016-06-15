require 'rails_helper'

RSpec.describe Scraper::CamdenTuscanyScraper, type: :model do
  describe ".scrape" do
    Given(:sample_page) { File.open('./spec/pages/camden_tuscany.html', 'r') }
    Given { stub_request(:get, Scraper::CamdenTuscanyScraper::LISTINGS_URL).to_return(body: sample_page) }
    When(:scraped_listings) { Scraper::CamdenTuscanyScraper.scrape }
    Then { scraped_listings.length == 5 }
    And { scraped_listings.first.class == ScrapedListing }
    And { scraped_listings.first.building_name == "Camden Tuscany" }
    And { scraped_listings.first.unit_name == "410" }
    And { scraped_listings.first.rent == 2479 }
    And { scraped_listings.first.available == Date.new(2016,07,02) }
    And { scraped_listings.first.beds == 1 }
    And { scraped_listings.first.square_feet == 725 }
    And { scraped_listings.first.lease_months == 15 }
  end
end
