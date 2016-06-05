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

  describe "#first_seen and #last_seen" do
    Given(:first_created_at) { DateTime.new(2015,10,11,12,13,14) }
    Given(:last_created_at) { DateTime.new(2015,05,17,18,19,20) }
    Given(:unit) { FactoryGirl.create(:unit, listings: [first_listing, last_listing]) }
    Given(:first_listing) { FactoryGirl.create(:listing, created_at: first_created_at) }
    Given(:last_listing) { FactoryGirl.create(:listing, created_at: last_created_at) }
    Then { unit.first_seen == first_created_at }
    And { unit.last_seen == last_created_at }
  end

  describe "#save_with_alerts" do
    describe "rent alerts" do
      Given(:unit) { FactoryGirl.create(:unit, rent: old_rent) }
      Given(:old_rent) { 100 }
      When { unit.rent = new_rent }

      context "when rent changed" do
        When(:new_rent) { old_rent + 100 }
        When { unit.save_with_alerts }
        Then { RentAlert.last.unit_id == unit.id }
        And { RentAlert.last.old_value == old_rent }
        And { RentAlert.last.new_value == new_rent }
      end

      context "when rent didn't change" do
        When(:new_rent) { old_rent }
        Then { expect{ unit.save_with_alerts }.to change{ RentAlert.count }.by(0) }
      end
    end

    describe "available alerts" do
      Given(:unit) { FactoryGirl.create(:unit, available: old_available) }
      Given(:old_available) { Date.new(2016, 9, 1) }
      When { unit.available = new_available }

      context "when available date changed" do
        When(:new_available) { old_available.advance(months: 1) }
        When { unit.save_with_alerts }
        Then { AvailableAlert.last.unit_id == unit.id }
        And { AvailableAlert.last.old_value == old_available }
        And { AvailableAlert.last.new_value == new_available }
      end

      context "when available date didn't change" do
        When(:new_available) { old_available }
        Then { expect{ unit.save_with_alerts }.to change{ AvailableAlert.count }.by(0) }
      end
    end
  end

  describe ".create_with_alerts" do
    Given(:attributes) { FactoryGirl.attributes_for(:unit) }

    describe "creates a new unit" do
      Then { expect{ Unit.create_with_alerts(attributes) }.to change{ Unit.count }.by(1) }
    end

    describe "creates a new NewUnitAlert" do
      Then { expect{ Unit.create_with_alerts(attributes) }.to change{ NewUnitAlert.count }.by(1) }
    end
  end
end
