require 'rails_helper'

RSpec.describe Scraper::AvaCortezHillScraper, type: :model do
  describe ".scrape" do
    Given(:sample_json) { File.open('./spec/pages/ava_cortez_hill.json', 'r') }
    Given { stub_request(:get, Scraper::AvaCortezHillScraper::LISTINGS_URL).to_return(body: sample_json) }
    When(:result) { Scraper::AvaCortezHillScraper.scrape }
    Then { result.length == 25 }
    And { result.first.is_a? Unit }
    And { result.first.building_name == "Ava Cortez Hill" }
    And { result.first.name == "505" }
    And { result.first.rent == 1565 }
    And { result.first.available == Date.new(2016,05,27) }
    And { result.first.beds == 0 }
    And { result.first.square_feet == 570 }
    And { result.first.lease_months == 12 }
  end
end
