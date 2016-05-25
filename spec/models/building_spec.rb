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
end
