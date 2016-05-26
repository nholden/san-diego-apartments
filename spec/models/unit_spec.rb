require 'rails_helper'

RSpec.describe Unit, type: :model do
  describe "unique name validation" do
    Given(:name) { "1301" }

    context "when a building with that name exists" do
      Given { FactoryGirl.create(:unit, name: name) }
      Then { Unit.new(name: name).valid? == false }
    end

    context "when a building with that name doesn't exist" do
      Then { Unit.new(name: name).valid? == true }
    end
  end

  describe "#building_name" do
    Given(:building_name) { "Warren Towers" }
    Given(:building) { FactoryGirl.create(:building, name: building_name) }
    Given(:unit) { FactoryGirl.create(:unit, building: building) }
    Then { unit.building_name == building_name }
  end

  describe "#rent" do
    Given(:rent) { 1675 }
    Given(:unit) { FactoryGirl.create(:unit, listings: [listing]) }
    Given(:listing) { FactoryGirl.create(:listing, rent: rent) }
    Then { unit.rent == rent }
  end

  describe "#available" do
    Given(:available) { Date.new(2016,10,11) }
    Given(:unit) { FactoryGirl.create(:unit, listings: [listing]) }
    Given(:listing) { FactoryGirl.create(:listing, available: available) }
    Then { unit.available == available }
  end

  describe "#lease_months" do
    Given(:lease_months) { 12 }
    Given(:unit) { FactoryGirl.create(:unit, listings: [listing]) }
    Given(:listing) { FactoryGirl.create(:listing, lease_months: lease_months) }
    Then { unit.lease_months == lease_months }
  end

  describe "#last_seen" do
    Given(:created_at) { DateTime.new(2015,10,11,12,13,14) }
    Given(:unit) { FactoryGirl.create(:unit, listings: [listing]) }
    Given(:listing) { FactoryGirl.create(:listing, created_at: created_at) }
    Then { unit.last_seen == created_at }
  end
end
