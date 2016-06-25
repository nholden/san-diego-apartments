require 'rails_helper'

RSpec.describe Building, type: :model do
  describe "unique name validation" do
    Given(:name) { "Ritz Carlton" }

    context "when a building with that name exists" do
      Given { FactoryGirl.create(:building, name: name) }
      Then { Building.new(name: name).valid? == false }
    end

    context "when a building with that name doesn't exist" do
      Then { Building.new(name: name).valid? == true }
    end
  end

  describe "#has_recently_seen_units_with_beds?" do
    Given(:building) { FactoryGirl.create(:building, units: units) }
    Given(:units) { [studio, two_br] }
    Given(:studio) { FactoryGirl.create(:unit, beds: 0, last_seen: last_seen) }
    Given(:two_br) { FactoryGirl.create(:unit, beds: 2, last_seen: last_seen) }

    context "when units were recently seen" do
      Given(:last_seen) { DateTime.now }
      Then { building.has_recently_seen_units_with_beds?(0) }
      And  { building.has_recently_seen_units_with_beds?(2) }
      And  { !building.has_recently_seen_units_with_beds?(1) }
    end

    context "when units were not recently seen" do
      Given(:last_seen) { 2.days.ago }
      Then { !building.has_recently_seen_units_with_beds?(0) }
      And  { !building.has_recently_seen_units_with_beds?(2) }
      And  { !building.has_recently_seen_units_with_beds?(1) }
    end
  end

  describe "recently_seen_starting_rent_for_beds" do
    Given(:building) { FactoryGirl.create(:building, units: units) }

    context "when units with beds exist" do
      Given(:units) { [expensive_one_br, expensive_two_br, cheap_one_br, cheap_two_br, old_cheap_one_br, old_cheap_two_br] }
      Given(:expensive_one_br) { FactoryGirl.create(:unit, beds: 1, rent: 3000, last_seen: DateTime.now) }
      Given(:expensive_two_br) { FactoryGirl.create(:unit, beds: 2, rent: 4000, last_seen: DateTime.now) }
      Given(:cheap_one_br) { FactoryGirl.create(:unit, beds: 1, rent: 1000, last_seen: DateTime.now) }
      Given(:cheap_two_br) { FactoryGirl.create(:unit, beds: 2, rent: 2000, last_seen: DateTime.now) }
      Given(:old_cheap_one_br) { FactoryGirl.create(:unit, beds: 1, rent: 500, last_seen: 2.days.ago) }
      Given(:old_cheap_two_br) { FactoryGirl.create(:unit, beds: 2, rent: 1000, last_seen: 2.days.ago) }
      Then { building.recently_seen_starting_rent_for_beds(1) == cheap_one_br.rent }
      And  { building.recently_seen_starting_rent_for_beds(2) == cheap_two_br.rent }
    end

    context "when no units exist" do
      Given(:units) { [] }
      Then { building.recently_seen_starting_rent_for_beds(1) == nil }
    end
  end
end
