require 'rails_helper'

RSpec.describe Scraper::LoftsAt707TenthScraper, type: :model do
  SAMPLE_PAGE = File.open('./spec/pages/lofts_at_707_tenth.html', 'r')
  SAMPLE_FLOOR_PLANS = [File.open('./spec/pages/lofts_at_707_tenth_floor_plan_0.html', 'r'),
                        File.open('./spec/pages/lofts_at_707_tenth_floor_plan_1.html', 'r'),
                        File.open('./spec/pages/lofts_at_707_tenth_floor_plan_2.html', 'r')]

  describe ".scrape" do
    Given { stub_request(:get, Scraper::LoftsAt707TenthScraper::LISTINGS_URL).to_return(body: SAMPLE_PAGE) }
    When(:scraped_listings) { Scraper::LoftsAt707TenthScraper.scrape }
    Then { scraped_listings.length == 4 }
    And { scraped_listings.first.class == ScrapedListing }
    And { scraped_listings.first.building_name == "Lofts at 707 Tenth" }
    And { scraped_listings.first.unit_name == "0611" }
    And { scraped_listings.first.rent == 1872 }
    And { scraped_listings.first.available == DateTime.now.to_date }
    And { scraped_listings.first.beds == 0 }
    And { scraped_listings.first.square_feet == 597 }
    And { scraped_listings.first.lease_months == 13 }
  end
end
