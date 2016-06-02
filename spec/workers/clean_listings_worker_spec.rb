require 'rails_helper'

RSpec.describe CleanListingsWorker do
  describe ".perform" do
    Given(:worker) { CleanListingsWorker.new }
    Given(:building) { FactoryGirl.create(:building) }
    Given(:unit) { FactoryGirl.create(:unit, building: building, listings: listings) }

    context "when the unit has many listings with no rent change" do
      Given(:listings) { (0..23).to_a.reverse.map { |n| FactoryGirl.create(:listing, created_at: n.hours.ago, rent: rent) } }
      Given(:rent) { 1234 }
      When { worker.perform(unit.id) }
      Then { unit.listings.include?(listings[0]) }
      And { unit.listings.include?(listings[-1]) }
      And { unit.listings.count == 2 }
    end

    context "when the unit has many listings with a rent change" do
      Given(:rent_change_time) { 12 }
      Given(:old_rent_listings) { (rent_change_time..23).to_a.reverse.map { |n| FactoryGirl.create(:listing, created_at: n.hours.ago, rent: old_rent) } }
      Given(:old_rent) { 1234 }
      Given(:new_rent_listings) { (0..rent_change_time).to_a.reverse.map { |n| FactoryGirl.create(:listing, created_at: n.hours.ago, rent: new_rent) } }
      Given(:new_rent) { 2345 }
      Given(:listings) { old_rent_listings + new_rent_listings }
      When { worker.perform(unit.id) }
      Then { unit.listings.include?(old_rent_listings[0]) }
      And { unit.listings.include?(new_rent_listings[0]) }
      And { unit.listings.include?(listings[-1]) }
      And { unit.listings.count == 3 }
    end
  end
end
