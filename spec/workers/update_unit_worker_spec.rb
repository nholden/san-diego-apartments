require 'rails_helper'

RSpec.describe UpdateUnitWorker do
  describe ".perform" do
    Given(:worker) { UpdateUnitWorker.new }
    Given(:scraped_listing) { FactoryGirl.create(:scraped_listing, building_name: building_name, unit_name: unit_name) }
    When { worker.perform(scraped_listing.id) }

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
