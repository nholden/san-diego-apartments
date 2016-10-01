require 'rails_helper'

RSpec.describe ScrapedListingProcessor do
  describe ".process" do
    Given(:attrs) do
      {
        unit_name: unit_name,
        building_name: building_name,
        rent: 1000,
        available: "2016-05-24",
        beds: 1,
        square_feet: 500,
        lease_months: 12,
        address: "1 First St.",
        website: "www.sweetapartment.org"
      }
    end

    When { ScrapedListingProcessor.process(attrs) }

    context "when building exists" do
      Given(:building) { FactoryGirl.create(:building) }
      Given(:building_name) { building.name }

      context "when unit exists" do
        Given(:unit) { FactoryGirl.create(:unit, building: building) }
        Given(:unit_name) { unit.name }
        Then { Unit.find_by_name(unit_name).last_seen.between?(5.seconds.ago, 5.seconds.from_now) }
      end

      context "when unit does not exist" do
        Given(:unit_name) { "503" }
        Then { Unit.last.name == unit_name }
      end
    end

    context "when building does not exist" do
      Given(:building_name) { "Bacon Chambers" }
      Given(:unit_name) { "34" }
      Then { Building.last.name == building_name }
      And { Unit.last.name == unit_name }
    end
  end
end
