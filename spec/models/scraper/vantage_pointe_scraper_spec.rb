require 'rails_helper'

RSpec.describe Scraper::VantagePointeScraper, type: :model do
  describe ".scrape" do
    Given(:sample_page) { File.open('./spec/pages/vantage_pointe.html', 'r') }
    Given { stub_request(:get, Scraper::VantagePointeScraper::LISTINGS_URL).to_return(body: sample_page) }
    When(:result) { Scraper::VantagePointeScraper.scrape }
    Then { result.length == 48 }
    And { result.first.is_a? Unit }
    And { result.first.building_name == "Vantage Pointe" }
    And { result.first.name == "219" }
    And { result.first.rent == 1920 }
    And { result.first.available == Date.new(2016,8,8) }
    And { result.first.beds == 1 }
    And { result.first.square_feet == 706 }
    And { result.first.lease_months == 12 }
  end
end
