require 'rails_helper'

RSpec.describe Unit, type: :model do
  SAMPLE_PAGE = File.open('./spec/pages/camden_tuscany.html', 'r')

  describe ".listings" do
    Given { stub_request(:get, Scraper::CamdenTuscanyScraper::LISTINGS_URL).to_return(body: SAMPLE_PAGE) }
    When(:listings) { Scraper::CamdenTuscanyScraper.listings }
    Then { listings.length == 5 }
    And { listings.first[:unit_name] == "410" }
    And { listings.first[:rent] == 2479 } 
    And { listings.first[:available] == Date.new(2016,07,02) }
    And { listings.first[:beds] == 1 }
    And { listings.first[:square_feet] == 725 }
    And { listings.first[:lease_months] == 15 }
  end
end
