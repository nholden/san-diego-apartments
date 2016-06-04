require 'rails_helper'

RSpec.describe NewListingWorker do
  describe ".perform" do
    Given(:worker) { NewListingWorker.new }
    Given(:scraped_listing) { FactoryGirl.create(:scraped_listing, building_name: building_name, unit_name: unit_name) }
    When { worker.perform(scraped_listing.id) }

    context "when building exists" do
      When(:building) { FactoryGirl.create(:building) }
      When(:building_name) { building.name }

      context "when unit exists" do
        When(:unit) { FactoryGirl.create(:unit, building: building) }
        When(:unit_name) { unit.name }
        Then { Listing.last.unit == unit }
      end

      context "when unit does not exist" do
        When(:unit_name) { "503" }
        Then { Listing.last.unit == Unit.find_by_name(unit_name) }
      end
    end

    context "when building does not exist" do
      When(:building_name) { "Bacon Chambers" }
      When(:unit_name) { "34" }
      Then { Unit.find_by_name(unit_name).building == Building.find_by_name(building_name) }
      And { Listing.last.unit == Unit.find_by_name(unit_name) }
    end
  end
end
