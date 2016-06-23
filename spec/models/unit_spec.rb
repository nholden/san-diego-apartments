require 'rails_helper'

RSpec.describe Unit, type: :model do
  describe "#building_name" do
    Given(:building_name) { "Warren Towers" }
    Given(:building) { FactoryGirl.create(:building, name: building_name) }
    Given(:unit) { FactoryGirl.create(:unit, building: building) }
    Then { unit.building_name == building_name }
  end

  describe "#first_seen" do
    Given(:created_at) { DateTime.new(2015,10,11,12,13,14) }
    Given(:unit) { FactoryGirl.create(:unit, created_at: created_at) }
    Then { unit.first_seen == created_at }
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

  describe ".update_or_create_by_with_alerts" do
    Given(:attributes) { FactoryGirl.attributes_for(:unit) }

    context "when the unit exists" do
      When(:unit) { FactoryGirl.create(:unit, attributes) }

      describe "it doesn't create a new unit" do
        Then { expect{ Unit.update_or_create_by_with_alerts(attributes) }.to change{ Unit.count }.by(0) }
      end

      describe "it returns the unit" do
        Then { Unit.update_or_create_by_with_alerts(attributes) == unit }
      end

      describe "it does not create a NewUnitAlert" do
        Then { expect{ Unit.update_or_create_by_with_alerts(attributes) }.to change{ NewUnitAlert.count }.by(0) }
      end
    end

    context "when the unit does not exist" do
      describe "it creates a new unit" do
        Then { expect{ Unit.update_or_create_by_with_alerts(attributes) }.to change{ Unit.count }.by(1) }
      end

      describe "it returns the new unit" do
        Then { Unit.update_or_create_by_with_alerts(attributes).is_a?(Unit) }
      end

      describe "it creates a new NewUnitAlert" do
        Then { expect{ Unit.update_or_create_by_with_alerts(attributes) }.to change{ NewUnitAlert.count }.by(1) }
      end
    end
  end

  describe "#recent_rent_alerts" do
    Given(:unit) { FactoryGirl.create(:unit, rent_alerts: rent_alerts) }
    Given(:rent_alerts) { [] }
    Given(:newest_new_value) { 9999 }
    Given { 10.times { |n| rent_alerts.push(FactoryGirl.create(:rent_alert)) } }
    Given { rent_alerts.push(FactoryGirl.create(:rent_alert, new_value: newest_new_value)) }
    Then { unit.recent_rent_alerts.length == 5 }
    And { unit.recent_rent_alerts[0].is_a?(RentAlert) }
    And { unit.recent_rent_alerts[0].new_value == newest_new_value }
  end

  describe "recently_seen scope" do
    Given(:unit) { FactoryGirl.create(:unit, last_seen: last_seen) }

    context "when the unit was seen today" do
      Given(:last_seen) { DateTime.now }
      Then { unit.in?(Unit.recently_seen) }
    end

    context "when the unit hasn't been seen today" do
      Given(:last_seen) { 2.days.ago }
      Then { !unit.in?(Unit.recently_seen) }
    end
  end

  describe "#rent_by_date" do
    Given(:unit) { FactoryGirl.create(:unit, rent_alerts: rent_alerts) }
    Given(:rent_alerts) { [] }
    Given(:starting_date) { DateTime.new(2016, 7, 4, 0, 0, 0) }
    Given(:starting_rent) { 2000 }
    Given(:daily_increase) { 100 }

    When do
      5.times do |n|
        rent_alerts.push(
          FactoryGirl.create(
            :rent_alert,
            created_at: starting_date.advance(days: n),
            old_value: (starting_rent + (n * daily_increase)),
            new_value: (starting_rent + (n+1) * daily_increase)
          )
        )
      end
    end

    Then do
      unit.rent_by_date == {
        starting_date.to_date                  => starting_rent + daily_increase,
        starting_date.advance(days: 1).to_date => starting_rent + (daily_increase * 2),
        starting_date.advance(days: 2).to_date => starting_rent + (daily_increase * 3),
        starting_date.advance(days: 3).to_date => starting_rent + (daily_increase * 4),
        starting_date.advance(days: 4).to_date => starting_rent + (daily_increase * 5)
      }
    end
  end
end
