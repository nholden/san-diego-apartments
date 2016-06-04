require 'rails_helper'

RSpec.describe Listing, type: :model do
  describe "#save_with_alerts" do
    describe "rent alerts" do
      Given(:unit) { FactoryGirl.create(:unit, listings: [existing_listing]) }
      Given(:existing_listing) { FactoryGirl.create(:listing, rent: unit_rent) }
      Given(:unit_rent) { 100 }
      Given(:listing) { FactoryGirl.build(:listing, rent: listing_rent, unit: unit) }

      context "when rent changed" do
        Given(:listing_rent) { unit_rent + 100 }
        When { listing.save_with_alerts }
        Then { RentAlert.last.unit_id == unit.id }
        And { RentAlert.last.old_value == unit_rent }
        And { RentAlert.last.new_value == listing_rent }
      end

      context "when rent didn't change" do
        Given(:listing_rent) { unit_rent }
        Then { expect{ listing.save_with_alerts }.to change{ RentAlert.count }.by(0) }
      end
    end

    describe "available alerts" do
      Given(:unit) { FactoryGirl.create(:unit, listings: [existing_listing]) }
      Given(:existing_listing) { FactoryGirl.create(:listing, available: unit_available) }
      Given(:unit_available) { Date.new(2016, 9, 1) }
      Given(:listing) { FactoryGirl.build(:listing, available: listing_available, unit: unit) }

      context "when available date changed" do
        Given(:listing_available) { unit_available.advance(months: 1) }
        When { listing.save_with_alerts }
        Then { AvailableAlert.last.unit_id == unit.id }
        And { AvailableAlert.last.old_value == unit_available }
        And { AvailableAlert.last.new_value == listing_available }
      end

      context "when available date didn't change" do
        Given(:listing_available) { unit_available }
        Then { expect{ listing.save_with_alerts }.to change{ AvailableAlert.count }.by(0) }
      end
    end

    describe "new unit alerts" do
      Given(:unit) { FactoryGirl.create(:unit, listings: existing_listings ) }
      Given(:listing) { FactoryGirl.build(:listing, unit: unit) }

      context "when listing is for a new unit" do
        Given(:existing_listings) { [] }
        When { listing.save_with_alerts }
        Then { NewUnitAlert.last.unit_id == unit.id }
      end

      context "when listing is for an exisiting unit" do
        Given(:existing_listings) { [FactoryGirl.create(:listing)] }
        Then { expect{ listing.save_with_alerts }.to change{ NewUnitAlert.count }.by(0) }
      end
    end
  end
end
