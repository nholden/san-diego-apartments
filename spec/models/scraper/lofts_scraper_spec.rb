require 'rails_helper'

RSpec.describe Scraper::LoftsScraper, type: :model do
  describe ".scrape" do
    LOFTS_FLOORPLANS.each do |floorplan|
      if floorplan["id"] == 138556
        Given do 
          stub_request(:get, Scraper::LoftsScraper::AVAILABILITY_URL_BASE + floorplan["id"].to_s).
          to_return(body: File.open('./spec/pages/lofts_available_floor_plan.html', 'r'))
        end
      elsif floorplan["id"] == 138626
        Given do 
          stub_request(:get, Scraper::LoftsScraper::AVAILABILITY_URL_BASE + floorplan["id"].to_s).
          to_return(body: File.open('./spec/pages/lofts_available_floor_plan_2.html', 'r'))
        end
      else
        Given do 
          stub_request(:get, Scraper::LoftsScraper::AVAILABILITY_URL_BASE + floorplan["id"].to_s).
          to_return(body: File.open('./spec/pages/lofts_unavailable_floor_plan.html', 'r'))
        end
      end
    end
    When(:scraped_listings) { Scraper::LoftsScraper.scrape }
    Then { scraped_listings.length == 3 }
    And { scraped_listings.first.class == ScrapedListing }
    And { scraped_listings.first.building_name == "Lofts at 707 Tenth" }
    And { scraped_listings.first.unit_name == "0611" }
    And { scraped_listings.first.rent == 1872 }
    And { scraped_listings.first.available == Date.new(2016,05,26) }
    And { scraped_listings.first.beds == 0 }
    And { scraped_listings.first.square_feet == 597 }
    And { scraped_listings.first.lease_months == 13 }
  end
end
