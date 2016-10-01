require 'rails_helper'

RSpec.describe Scraper::MarketStreetVillageScraper, type: :model do
  describe ".scrape" do
    Given(:sample_page) { File.open('./spec/pages/market_street_village.html', 'r') }
    Given { stub_request(:get, Scraper::MarketStreetVillageScraper::LISTINGS_URL).to_return(body: sample_page) }
    When(:result) { Scraper::MarketStreetVillageScraper.scrape }
    Then { result.length == 12 }
    And { result.first.is_a? Unit }
    And { result.first.building_name == "Market Street Village" }
    And { result.first.name == "313" }
    And { result.first.rent == 1625 }
    And { result.first.available == Date.new(2016,06,21) }
    And { result.first.beds == 0 }
    And { result.first.square_feet == 491 }
    And { result.first.lease_months == 12 }
  end
end
