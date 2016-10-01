require 'rails_helper'

RSpec.describe LoftsScraper, type: :model do
  describe ".scrape" do
    LOFTS_FLOORPLANS.each do |floorplan|
      if floorplan["id"] == 138556
        Given do 
          stub_request(:get, LoftsScraper::AVAILABILITY_URL_BASE + floorplan["id"].to_s).
          to_return(body: File.open('./spec/pages/lofts_available_floor_plan.html', 'r'))
        end
      elsif floorplan["id"] == 138626
        Given do 
          stub_request(:get, LoftsScraper::AVAILABILITY_URL_BASE + floorplan["id"].to_s).
          to_return(body: File.open('./spec/pages/lofts_available_floor_plan_2.html', 'r'))
        end
      else
        Given do 
          stub_request(:get, LoftsScraper::AVAILABILITY_URL_BASE + floorplan["id"].to_s).
          to_return(body: File.open('./spec/pages/lofts_unavailable_floor_plan.html', 'r'))
        end
      end
    end
    When(:result) { LoftsScraper.scrape }
    Then { result.length == 3 }
    And { result.first.is_a? Unit }
    And { result.first.building_name == "Lofts at 707 Tenth" }
    And { result.first.name == "0611" }
    And { result.first.rent == 1872 }
    And { result.first.available == Date.new(2016,05,26) }
    And { result.first.beds == 0 }
    And { result.first.square_feet == 597 }
    And { result.first.lease_months == 13 }
  end
end
