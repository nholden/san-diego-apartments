require 'rails_helper'

RSpec.describe CamdenTuscanyScraper, type: :model do
  describe ".scrape" do
    Given(:sample_page) { File.open('./spec/pages/camden_tuscany.html', 'r') }
    Given { stub_request(:get, CamdenTuscanyScraper::LISTINGS_URL).to_return(body: sample_page) }
    When(:result) { CamdenTuscanyScraper.scrape }
    Then { result.length == 5 }
    And { result.first.is_a? Unit }
    And { result.first.building_name == "Camden Tuscany" }
    And { result.first.name == "410" }
    And { result.first.rent == 2479 }
    And { result.first.available == Date.new(2016,07,02) }
    And { result.first.beds == 1 }
    And { result.first.square_feet == 725 }
    And { result.first.lease_months == 15 }
  end
end
